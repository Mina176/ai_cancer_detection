import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/common_widgets/profile_image.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class DoctorSettingsLayout extends StatelessWidget {
  const DoctorSettingsLayout({
    super.key,
    required this.context,
    required this.ref,
    required this.profile,
  });
  final BuildContext context;
  final WidgetRef ref;
  final DoctorProfileModel profile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.kHorizontalPadding),
      child: Column(
        children: [
          context.isLandscape ? Sizes.kVerticalPadding.heightBox : 0.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileImage(radius: 50),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        'Personal Information',
                        style: context.bodyMedium?.semiBold,
                      ),
                      TextButton(
                        onPressed: () => context.pushNamed(
                          AppRoute.labForm.name,
                          queryParameters: {'isEditing': 'true'},
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Full Name'),
                      subtitle: Text(profile.fullName ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('Bio'),
                      subtitle: Text(profile.bio ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.science_outlined),
                      title: const Text('Specialization'),
                      subtitle: Text(profile.specialization ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.description),
                      title: const Text('License Number'),
                      subtitle: Text(profile.licenseNumber ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.local_hospital),
                      title: const Text('Hospital Name'),
                      subtitle: Text(profile.hospitalName ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.work_outline),
                      title: const Text('Years of Experience'),
                      subtitle: Text(
                        profile.yearsOfExperience?.toString() ?? 'Not set',
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.people_outline),
                      title: const Text('Number of Patients'),
                      subtitle: Text(
                        profile.patients?.length.toString() ?? 'Not set',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
