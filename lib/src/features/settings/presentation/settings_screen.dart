import 'dart:typed_data';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:cancer_ai_detection/src/features/settings/controller/allergies_provider.dart';
import 'package:cancer_ai_detection/src/features/settings/controller/medication_provider.dart';
import 'package:cancer_ai_detection/src/features/settings/controller/profile_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/primary_button.dart';
import 'package:cancer_ai_detection/src/common_widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    if (newUserName != null && newUserName!.trim().isNotEmpty) {
      await client.userProfileEdit.changeUserName(newUserName!.trim());
    }
    if (newFullName != null && newFullName!.trim().isNotEmpty) {
      await client.userProfileEdit.changeFullName(newFullName!.trim());
    }
    final _ = await ref.refresh(userProfileProvider.future);

    if (mounted) context.goNamed(AppRoute.home.name);
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(userProfileProvider);
    final allergiesAsync = ref.watch(allergiesProvider);
    final medicationsAsync = ref.watch(medicationsProvider);
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
                          UserInfoListTile(
                            title: 'Allergires',
                            asyncData: allergiesAsync,
                            onTap: () =>
                                context.goNamed(AppRoute.allergies.name),
                            itemLabelBuilder: (allergy) => allergy.allergen,
                          ),
                          UserInfoListTile(
                            title: 'Medications',
                            asyncData: medicationsAsync,
                            onTap: () =>
                                context.goNamed(AppRoute.medications.name),
                            itemLabelBuilder: (medication) => medication.name,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              PrimaryButton(
                label: 'Save Changes',
                onPressed: saveChanges,
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

class UserInfoListTile<T> extends StatelessWidget {
  const UserInfoListTile({
    super.key,
    required this.title,
    required this.asyncData,
    required this.onTap,
    required this.itemLabelBuilder,
  });

  final String title;
  final AsyncValue<List<T>> asyncData;
  final VoidCallback onTap;
  final String Function(T) itemLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: asyncData.when(
          data: (data) {
            if (data.isEmpty) return const Text('None added yet');
            return Text(
              data.map(itemLabelBuilder).join(', '),
              overflow: TextOverflow.ellipsis,
            );
          },
          loading: () => const Text(''),
          error: (error, stack) => Text('Error: $error'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
