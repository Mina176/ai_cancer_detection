import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/common_widgets/copy_icon.dart';
import 'package:cancer_ai_detection/src/common_widgets/profile_image.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/controllers/allergies_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/controller/health_measurement_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/controller/medical_history_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/controller/medication_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/pateint_doctors/controller/patient_doctors_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  String formatEnumLabel(dynamic value, {String fallback = 'Not set'}) {
    if (value == null) return fallback;
    try {
      final enumName = (value as dynamic).name;
      if (enumName is String && enumName.isNotEmpty) {
        return enumName;
      }
    } catch (_) {
      // Fall through to string parsing.
    }
    final raw = value.toString();
    if (raw.contains('.')) {
      return raw.split('.').last;
    }
    return raw;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    final isDoctor = role == 'doctor';
    final isLabSpecialist = role == 'labSpecialist';
    final allergiesAsync = ref.watch(allergiesProvider);
    final medicationsAsync = ref.watch(medicationsProvider);
    final medicalHistoryAsync = ref.watch(medicalHistoryProvider);
    final healthMeasurementsAsync = ref.watch(healthMeasurementProvider);
    final patientDoctorAsync = ref.watch(patientDoctorsProvider);
    final body = isDoctor
        ? ref
              .watch(doctorProfileProvider)
              .when(
                data: (profile) => buildDoctorLayout(context, ref, profile),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              )
        : isLabSpecialist
        ? ref
              .watch(labProfileProvider)
              .when(
                data: (profile) => buildLabLayout(context, ref, profile),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              )
        : ref
              .watch(patientProfileProvider)
              .when(
                data: (profile) => buildPatientLayout(
                  context,
                  ref,
                  profile,
                  allergiesAsync,
                  medicationsAsync,
                  medicalHistoryAsync,
                  healthMeasurementsAsync,
                  patientDoctorAsync,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              );
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(title: const Text('Settings')),
      body: body,
    );
  }

  Widget buildDoctorLayout(
    BuildContext context,
    WidgetRef ref,
    DoctorProfileModel profile,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.kHorizontalPadding),
      child: Column(
        children: [
          context.isLandscape ? Sizes.kVerticalPadding.heightBox : 0.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 14,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileImage(radius: 50),
                  TextButton(
                    onPressed: () =>
                        context.pushNamed(AppRoute.doctorForm.name),
                    child: const Text('Edit Profile'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Personal Information',
                        style: context.bodyMedium?.semiBold,
                      ),
                    ],
                  ),
                  TextFormField(
                    key: ValueKey(profile.id.toString()),
                    initialValue: profile.id.toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      suffixIcon: CopyIcon(textToCopy: profile.id.toString()),
                    ),
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

  Widget buildLabLayout(
    BuildContext context,
    WidgetRef ref,
    LabProfileModel profile,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.kHorizontalPadding),
      child: Column(
        children: [
          context.isLandscape ? Sizes.kVerticalPadding.heightBox : 0.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 14,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileImage(radius: 50),
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Lab specialist profile form is not available yet.',
                        ),
                      ),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Personal Information',
                        style: context.bodyMedium?.semiBold,
                      ),
                    ],
                  ),
                  TextFormField(
                    key: ValueKey(profile.id.toString()),
                    initialValue: profile.id.toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      suffixIcon: CopyIcon(textToCopy: profile.id.toString()),
                    ),
                  ),
                  TextFormField(
                    initialValue: profile.name ?? '',
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.science_outlined),
                      title: const Text('Lab Type'),
                      subtitle: Text(profile.labType ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: const Text('Address'),
                      subtitle: Text(profile.address ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone_outlined),
                      title: const Text('Phone'),
                      subtitle: Text(profile.phone ?? 'Not set'),
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

  Widget buildPatientLayout(
    BuildContext context,
    WidgetRef ref,
    PatientProfileModel profile,
    AsyncValue allergiesAsync,
    AsyncValue medicationsAsync,
    AsyncValue medicalHistoryAsync,
    AsyncValue healthMeasurementsAsync,
    AsyncValue patientDoctorAsync,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.kHorizontalPadding),
      child: Column(
        children: [
          context.isLandscape ? Sizes.kVerticalPadding.heightBox : 0.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 14,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileImage(radius: 50),
                  TextButton(
                    onPressed: () =>
                        context.pushNamed(AppRoute.patientForm.name),
                    child: const Text('Edit Profile'),
                  ),
                  Row(
                    children: [
                      Text(
                        'Personal Information',
                        style: context.bodyMedium?.semiBold,
                      ),
                    ],
                  ),
                  TextFormField(
                    key: ValueKey(profile.id.toString()),
                    initialValue: profile.id.toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      suffixIcon: CopyIcon(textToCopy: profile.id.toString()),
                    ),
                  ),
                  TextFormField(
                    initialValue: profile.fullName ?? '',
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    readOnly: true,
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.cake_outlined),
                      title: const Text('Date of Birth'),
                      subtitle: Text(
                        profile.dob != null
                            ? DateFormat('dd/MM/yyyy').format(profile.dob!)
                            : 'Not set',
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.wc_rounded),
                      title: const Text('Gender'),
                      subtitle: Text(formatEnumLabel(profile.gender)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.bloodtype_outlined),
                      title: const Text('Blood Type'),
                      subtitle: Text(formatEnumLabel(profile.bloodType)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.smoke_free_rounded),
                      title: const Text('Smoking Status'),
                      subtitle: Text(profile.smokingStatus ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.timelapse_rounded),
                      title: const Text('Smoking Years'),
                      subtitle: Text(
                        profile.smokingYears?.toString() ?? 'Not set',
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.local_bar_outlined),
                      title: const Text('Alcohol Frequency'),
                      subtitle: Text(profile.alcoholFreq ?? 'Not set'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.directions_run_rounded),
                      title: const Text('Exercise Frequency'),
                      subtitle: Text(profile.exerciseFreq ?? 'Not set'),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Medical Information',
                        style: context.bodyMedium?.semiBold,
                      ),
                    ],
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Allergies'),
                      subtitle: allergiesAsync.when(
                        data: (data) {
                          if (data.isEmpty) return const Text('None added yet');
                          return Text(
                            data.map((allergy) => allergy.allergen).join(', '),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                        loading: () => const Text(''),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => context.pushNamed(AppRoute.allergies.name),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Medications'),
                      subtitle: medicationsAsync.when(
                        data: (data) {
                          if (data.isEmpty) return const Text('None added yet');
                          return Text(
                            data
                                .map((medication) => medication.name)
                                .join(', '),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                        loading: () => const Text(''),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => context.pushNamed(AppRoute.medications.name),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Medical History'),
                      subtitle: medicalHistoryAsync.when(
                        data: (data) {
                          if (data.isEmpty) return const Text('None added yet');
                          return Text(
                            data.map((history) => history.title).join(', '),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                        loading: () => const Text(''),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () =>
                          context.pushNamed(AppRoute.medicalHistory.name),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Health Measurements'),
                      subtitle: healthMeasurementsAsync.when(
                        data: (data) {
                          if (data.isEmpty) return const Text('None added yet');
                          return Text(
                            data
                                .map(
                                  (measurement) =>
                                      '${formatEnumLabel(measurement.name)}: ${measurement.value}',
                                )
                                .join(', '),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                        loading: () => const Text(''),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () =>
                          context.pushNamed(AppRoute.healthMeasurments.name),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Your Doctors'),
                      subtitle: patientDoctorAsync.when(
                        data: (data) {
                          if (data.isEmpty) return const Text('None added yet');
                          return Text(
                            data
                                .map(
                                  (patientDoctor) =>
                                      patientDoctor.doctor!.fullName!,
                                )
                                .join(', '),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                        loading: () => const Text(''),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () =>
                          context.pushNamed(AppRoute.selectedDoctor.name),
                    ),
                  ),
                  1.heightBox,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
