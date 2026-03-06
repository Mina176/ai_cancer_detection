import 'dart:typed_data';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/settings/data/profile_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Future<void> _pickProfileImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      final uint8ListImage = await image.readAsBytes();
      final ByteData imageByteData = ByteData.view(
        uint8ListImage.buffer,
      );
      await client.userProfileEdit.setUserImage(
        imageByteData,
      );
      ref.invalidate(userProfileProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(userProfileProvider);
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              forceMaterialTransparency: true,
              title: const Text('Settings'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: userProfileAsync.when(
        data: (profile) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
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
                          ProfileImage(profile: profile, radius: 50),
                          TextButton(
                            onPressed: _pickProfileImage,
                            child: const Text('Change Profile Picture'),
                          ),
                          TextFormField(
                            initialValue: profile.userName ?? '',
                            decoration: const InputDecoration(
                              labelText: 'User Name',
                            ),
                            onSaved: (value) {
                              if (value != null && value.isNotEmpty) {
                                client.userProfileEdit.changeUserName(value);
                              }
                            },
                          ),
                          TextFormField(
                            initialValue: profile.fullName ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                            ),
                            onSaved: (value) {
                              if (value != null && value.isNotEmpty) {
                                client.userProfileEdit.changeFullName(value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.kBottomButtonPadding,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save Changes'),
                ),
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

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.profile,
    this.radius = 50,
  });
  final UserProfileModel profile;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(
        profile.imageUrl != null
            ? '${profile.imageUrl!.toString().replaceAll(
                'http://localhost:6000',
                'https://gp-api.lasheen.dev',
              )}&v=${DateTime.now().millisecondsSinceEpoch}'
            : 'https://ui-avatars.com/api/?name=${profile.fullName ?? 'User'}&size=200&background=2B9DEE&color=fff',
      ),
    );
  }
}
