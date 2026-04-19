import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/profile_image.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/controllers/allergies_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/controller/health_measurement_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/controller/medical_history_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/controller/medication_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/pateint_doctors/controller/list_my_doctors.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

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
    final patientDoctorAsync = ref.watch(listMyDoctorsProvider);
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
                  ProfileInfoCard(
                    icon: Icons.person,
                    title: 'Full Name',
                    subtitle: profile.fullName ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.info_outline,
                    title: 'Bio',
                    subtitle: profile.bio ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.work_outline,
                    title: 'Specialization',
                    subtitle: profile.specialization ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.badge_outlined,
                    title: 'License Number',
                    subtitle: profile.licenseNumber ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.local_hospital_outlined,
                    title: 'Hospital Name',
                    subtitle: profile.hospitalName ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.timelapse_rounded,
                    title: 'Years of Experience',
                    subtitle:
                        profile.yearsOfExperience?.toString() ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    subtitle: profile.phone ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.info_outline,
                    title: 'Patient Count',
                    subtitle: profile.patients?.length.toString() ?? '0',
                  ),
                  8.heightBox,
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
                            context.pushNamed(AppRoute.patientForm.name),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                  ProfileInfoCard(
                    icon: Icons.person,
                    title: 'Full Name',
                    subtitle: profile.fullName ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.cake_outlined,
                    title: 'Date of Birth',
                    subtitle: profile.dob != null
                        ? DateFormat('dd/MM/yyyy').format(profile.dob!)
                        : 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.wc_rounded,
                    title: 'Gender',
                    subtitle: formatEnumLabel(profile.gender),
                  ),
                  ProfileInfoCard(
                    icon: Icons.bloodtype_outlined,
                    title: 'Blood Type',
                    subtitle: formatEnumLabel(profile.bloodType),
                  ),
                  ProfileInfoCard(
                    icon: Icons.smoke_free_rounded,
                    title: 'Smoking Status',
                    subtitle: profile.smokingStatus ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.timelapse_rounded,
                    title: 'Smoking Years',
                    subtitle: profile.smokingYears?.toString() ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.local_bar_outlined,
                    title: 'Alcohol Frequency',
                    subtitle: profile.alcoholFreq ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.directions_run_rounded,
                    title: 'Exercise Frequency',
                    subtitle: profile.exerciseFreq ?? 'Not set',
                  ),
                  Row(
                    children: [
                      Text(
                        'Medical Information',
                        style: context.bodyMedium?.semiBold,
                      ),
                    ],
                  ),
                  AsyncNavigationCard(
                    title: 'Allergies',
                    asyncValue: allergiesAsync,
                    nextRoute: AppRoute.allergies,
                    subtitleBuilder: (data) =>
                        data.map((allergy) => allergy.allergen).join(', '),
                  ),
                  AsyncNavigationCard(
                    title: 'Medications',
                    asyncValue: medicationsAsync,
                    nextRoute: AppRoute.medications,
                    subtitleBuilder: (data) =>
                        data.map((medication) => medication.name).join(', '),
                  ),
                  AsyncNavigationCard(
                    title: 'Medical History',
                    asyncValue: medicalHistoryAsync,
                    nextRoute: AppRoute.medicalHistory,
                    subtitleBuilder: (data) =>
                        data.map((history) => history.title).join(', '),
                  ),
                  AsyncNavigationCard(
                    title: 'Health Measurements',
                    asyncValue: healthMeasurementsAsync,
                    nextRoute: AppRoute.healthMeasurments,
                    subtitleBuilder: (data) {
                      return data
                          .map(
                            (measurement) =>
                                '${formatEnumLabel(measurement.name)}: ${measurement.value}',
                          )
                          .join(', ');
                    },
                  ),
                  AsyncNavigationCard(
                    title: 'Your Doctors',
                    asyncValue: patientDoctorAsync,
                    nextRoute: AppRoute.selectedDoctor,
                    subtitleBuilder: (data) {
                      return data
                          .map(
                            (patientDoctor) => patientDoctor.doctor!.fullName!,
                          )
                          .join(', ');
                    },
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
                            context.pushNamed(AppRoute.labForm.name),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                  ProfileInfoCard(
                    icon: Icons.person,
                    title: 'Full Name',
                    subtitle: profile.name ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.science_outlined,
                    title: 'Lab Type',
                    subtitle: profile.labType ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.location_on_outlined,
                    title: 'Address',
                    subtitle: profile.address ?? 'Not set',
                  ),
                  ProfileInfoCard(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    subtitle: profile.phone ?? 'Not set',
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

class AsyncNavigationCard extends StatelessWidget {
  const AsyncNavigationCard({
    super.key,
    required this.title,
    required this.asyncValue,
    required this.nextRoute,
    required this.subtitleBuilder,
  });

  final String title;
  final AsyncValue asyncValue;
  final AppRoute nextRoute;
  final String Function(dynamic data) subtitleBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: asyncValue.when(
          data: (data) {
            if (data is List && data.isEmpty) {
              return const Text('None added yet');
            }
            return Text(
              subtitleBuilder(data),
              overflow: TextOverflow.ellipsis,
            );
          },
          loading: () => const Text(''),
          error: (error, stack) => Text('Error: $error'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => context.pushNamed(nextRoute.name),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
