import 'dart:typed_data';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/settings/data/allergies_provider.dart';
import 'package:cancer_ai_detection/features/settings/data/profile_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:cancer_ai_detection/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String? newUserName;
  String? newFullName;

  Future<void> pickProfileImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      final uint8ListImage = await image.readAsBytes();
      final ByteData imageByteData = ByteData.view(uint8ListImage.buffer);

      await client.userProfileEdit.setUserImage(imageByteData);

      final _ = await ref.refresh(userProfileProvider.future);
    }
  }

  Future<void> saveChanges(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    setState(() => isLoading = true);

    try {
      if (newUserName != null && newUserName!.trim().isNotEmpty) {
        await client.userProfileEdit.changeUserName(newUserName!.trim());
      }
      if (newFullName != null && newFullName!.trim().isNotEmpty) {
        await client.userProfileEdit.changeFullName(newFullName!.trim());
      }
      final _ = await ref.refresh(userProfileProvider.future);

      if (context.mounted) context.go(homeRoute);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(userProfileProvider);
    final allergiesAsync = ref.watch(allergiesProvider);
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Settings'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: userProfileAsync.when(
        data: (profile) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.kHorizontalPadding,
            vertical: Sizes.kVerticalPadding,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.isLandscape
                            ? 0
                            : Sizes.kVerticalPadding,
                      ),
                      child: Column(
                        spacing: 14,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileImage(radius: 50),
                          TextButton(
                            onPressed: pickProfileImage,
                            child: const Text('Change Profile Picture'),
                          ),
                          TextFormField(
                            initialValue: profile.userName ?? '',
                            decoration: const InputDecoration(
                              labelText: 'User Name',
                            ),
                            onSaved: (value) => newUserName = value,
                          ),
                          TextFormField(
                            initialValue: profile.fullName ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                            ),
                            onSaved: (value) => newFullName = value,
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Allergies'),
                              subtitle: allergiesAsync.when(
                                data: (allergies) => Text(
                                  allergies.map((a) => a.allergen).join(', '),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                loading: () => const Text(''),
                                error: (error, stack) => Text('Error: $error'),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () =>
                                  context.go('$settingsRoute/$allergiesRoute'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : () => saveChanges(context),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Save Changes'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
