import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/controllers/allergies_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/controller/health_measurement_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/controller/medical_history_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/controller/medication_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/patient_doctor/controller/select_doctor_controller.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/doctor_settings_layout.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/lab_settings_layout.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/patient_settings_layout.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    final isDoctor = role == 'doctor';
    final isLabSpecialist = role == 'labSpecialist';
    final body = isDoctor
        ? ref
              .watch(doctorProfileProvider)
              .when(
                data: (profile) => DoctorSettingsLayout(
                  context: context,
                  ref: ref,
                  profile: profile,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              )
        : isLabSpecialist
        ? ref
              .watch(labProfileProvider)
              .when(
                data: (profile) => LabSettingsLayout(
                  context: context,
                  ref: ref,
                  profile: profile,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              )
        : ref
              .watch(patientProfileProvider)
              .when(
                data: (profile) => PatientSettingsLayout(
                  context: context,
                  profile: profile,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              );
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Settings'),
              actions: [
                IconButton(
                  onPressed: () async {
                    await client.auth.signOutDevice();
                    ref.read(userRoleProvider.notifier).setRole(null);
                  },
                  icon: const Icon(Icons.logout_rounded),
                ),
              ],
            ),
      body: body,
    );
  }
}
