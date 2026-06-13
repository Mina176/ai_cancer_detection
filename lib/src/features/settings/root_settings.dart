import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/doctor_settings_layout.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/lab_settings_layout.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/patient_settings_layout.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
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
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: _isSigningOut
                ? null
                : () async {
                    setState(() => _isSigningOut = true);
                    try {
                      await client.auth.signOutDevice();
                      ref.read(userRoleProvider.notifier).setRole(null);
                    } finally {
                      if (mounted) {
                        setState(() => _isSigningOut = false);
                      }
                    }
                  },
            icon: _isSigningOut
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: body,
    );
  }
}
