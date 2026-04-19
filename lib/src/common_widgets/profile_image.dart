import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({
    super.key,
    this.radius = 50,
  });

  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    final isDoctor = role == 'doctor';
    final isLabSpecialist = role == 'labSpecialist';
    if (isLabSpecialist) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const NetworkImage(
          'https://ui-avatars.com/api/?name=Lab+Specialist&size=200&background=2B9DEE&color=fff',
        ),
      );
    }

    final userProfileAsync = isDoctor
        ? ref.watch(doctorProfileProvider)
        : ref.watch(patientProfileProvider);
    final profile = userProfileAsync.value;
    final imageUrl = isDoctor
        ? (profile as DoctorProfileModel).imageUrl
        : (profile as PatientProfileModel).imageUrl;
    final name = isDoctor
        ? (profile as DoctorProfileModel).fullName
        : (profile as PatientProfileModel).fullName;
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(
        imageUrl != null
            ? '${imageUrl.toString().replaceAll(
                'http://localhost:6000',
                'https://gp-api.lasheen.dev',
              )}&v=${DateTime.now().millisecondsSinceEpoch}'
            : 'https://ui-avatars.com/api/?name=${name ?? 'User'}&size=200&background=2B9DEE&color=fff',
      ),
    );
  }
}
