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
                        onPressed: () =>
                            context.pushNamed(AppRoute.doctorForm.name),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: profile.fullName ?? '',
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Full Name'),
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
