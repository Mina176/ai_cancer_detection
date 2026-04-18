import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/common_widgets/profile_image.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Greeting(),
        UserCard(),
      ],
    );
  }
}

class Greeting extends ConsumerWidget {
  const Greeting({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.read(userRoleProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Good Morning', style: context.headlineMedium?.extraBold),
        Text(
          role == 'doctor'
              ? "Ready to start today's diagnostics?"
              : role == 'labSpecialist'
              ? 'Ready to process patients?'
              : 'Welcome back!',
        ),
      ],
    );
  }
}

class UserCard extends ConsumerWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    final isDoctor = role == 'doctor';
    final isLabSpecialist = role == 'labSpecialist';

    if (isLabSpecialist) {
      return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFF3F4F6),
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Row(
            children: [
              ProfileImage(radius: 20),
              if (context.isLandscape) 8.widthBox,
              if (context.isLandscape)
                Text(
                  'Lab Specialist',
                  style: context.bodyMedium?.extraBold,
                ),
            ],
          ),
        ),
      );
    }

    final userProfileAsync = isDoctor
        ? ref.watch(doctorProfileProvider)
        : ref.watch(patientProfileProvider);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: const Color(0xFFF3F4F6),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: userProfileAsync.when(
          data: (profile) {
            final name = isDoctor
                ? (profile as DoctorProfileModel).fullName
                : (profile as PatientProfileModel).fullName;
            return Row(
              children: [
                ProfileImage(
                  radius: 20,
                ),
                if (context.isLandscape) 8.widthBox,
                if (context.isLandscape)
                  Text(
                    name ?? 'User',
                    style: context.bodyMedium?.extraBold,
                  ),
              ],
            );
          },
          loading: () => CircleAvatar(
            radius: 20,
            child: Text(''),
          ),
          error: (error, stack) => CircleAvatar(
            radius: 20,
            child: Text(''),
          ),
        ),
      ),
    );
  }
}
