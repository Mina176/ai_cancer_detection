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
import 'package:intl/intl.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void goToEditProfile() {
    final role = ref.read(userRoleProvider);
    if (role == 'doctor') {
      context.pushNamed(AppRoute.doctorForm.name);
      return;
    }
    if (role == 'patient') {
      context.pushNamed(AppRoute.patientForm.name);
      return;
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lab specialist profile form is not available yet.'),
        ),
      );
    }
  }

  Widget _buildCommonProfileHeader({
    required String userId,
    required String? fullName,
  }) {
    return Column(
      spacing: 14,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ProfileImage(radius: 50),
        TextButton.icon(
          onPressed: goToEditProfile,
          label: const Text('Edit Profile'),
        ),
        TextFormField(
          key: ValueKey(userId),
          initialValue: userId,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'User ID',
            suffixIcon: CopyIcon(
              textToCopy: userId,
            ),
          ),
        ),
        TextFormField(
          initialValue: fullName ?? '',
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Full Name',
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent({required Widget profileHeader}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isLandscape
            ? Sizes.kHorizontalPadding
            : Sizes.kHorizontalPadding,
      ),
      child: Column(
        children: [
          context.isLandscape ? Sizes.kVerticalPadding.heightBox : 0.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: profileHeader,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(userRoleProvider);
    final isDoctor = role == 'doctor';
    final isLabSpecialist = role == 'labSpecialist';

    final allergiesAsync = ref.watch(allergiesProvider);
    final medicationsAsync = ref.watch(medicationsProvider);
    final medicalHistoryAsync = ref.watch(medicalHistoryProvider);
    final healthMeasurementsAsync = ref.watch(healthMeasurementProvider);
    final patientDoctorAsync = ref.watch(patientDoctorsProvider);

    final userProfileBody = isDoctor
        ? ref
              .watch(doctorProfileProvider)
              .when(
                data: (profile) {
                  return _buildProfileContent(
                    profileHeader: _buildCommonProfileHeader(
                      userId: profile.id.toString(),
                      fullName: profile.fullName,
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              )
        : isLabSpecialist
        ? ref
              .watch(labProfileProvider)
              .when(
                data: (profile) {
                  return _buildProfileContent(
                    profileHeader: Column(
                      spacing: 14,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildCommonProfileHeader(
                          userId: profile.id.toString(),
                          fullName: profile.name,
                        ),
                        ProfileInfoTile(
                          icon: Icons.science_outlined,
                          title: 'Lab Type',
                          value: profile.labType ?? 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.location_on_outlined,
                          title: 'Address',
                          value: profile.address ?? 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: profile.phone ?? 'Not set',
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              )
        : ref
              .watch(patientProfileProvider)
              .when(
                data: (profile) {
                  return _buildProfileContent(
                    profileHeader: Column(
                      spacing: 14,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildCommonProfileHeader(
                          userId: profile.id.toString(),
                          fullName: profile.fullName,
                        ),
                        ProfileInfoTile(
                          icon: Icons.cake_outlined,
                          title: 'Date of Birth',
                          value: profile.dob != null
                              ? DateFormat('dd/MM/yyyy').format(profile.dob!)
                              : 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.wc_rounded,
                          title: 'Gender',
                          value: profile.gender?.name ?? 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.bloodtype_outlined,
                          title: 'Blood Type',
                          value: profile.bloodType?.name ?? 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.smoke_free_rounded,
                          title: 'Smoking Status',
                          value: profile.smokingStatus ?? 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.timelapse_rounded,
                          title: 'Smoking Years',
                          value: profile.smokingYears?.toString() ?? 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.local_bar_outlined,
                          title: 'Alcohol Frequency',
                          value: profile.alcoholFreq ?? 'Not set',
                        ),
                        ProfileInfoTile(
                          icon: Icons.directions_run_rounded,
                          title: 'Exercise Frequency',
                          value: profile.exerciseFreq ?? 'Not set',
                        ),
                        UserInfoListTile(
                          title: 'Allergies',
                          asyncData: allergiesAsync,
                          onTap: () => context.goNamed(AppRoute.allergies.name),
                          itemLabelBuilder: (allergy) => allergy.allergen,
                        ),
                        UserInfoListTile(
                          title: 'Medications',
                          asyncData: medicationsAsync,
                          onTap: () =>
                              context.goNamed(AppRoute.medications.name),
                          itemLabelBuilder: (medication) => medication.name,
                        ),
                        UserInfoListTile(
                          title: 'Medical History',
                          asyncData: medicalHistoryAsync,
                          onTap: () =>
                              context.goNamed(AppRoute.medicalHistory.name),
                          itemLabelBuilder: (medicalHistory) =>
                              medicalHistory.title,
                        ),
                        UserInfoListTile(
                          title: 'Health Measurements',
                          asyncData: healthMeasurementsAsync,
                          onTap: () =>
                              context.goNamed(AppRoute.healthMeasurments.name),
                          itemLabelBuilder: (measurement) =>
                              '${measurement.name.name}: ${measurement.value}',
                        ),
                        UserInfoListTile(
                          title: 'Your Doctors',
                          asyncData: patientDoctorAsync,
                          onTap: () =>
                              context.goNamed(AppRoute.chooseDoctor.name),
                          itemLabelBuilder: (patientDoctor) =>
                              patientDoctor.doctor!.fullName!,
                        ),
                        1.heightBox,
                      ],
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              );
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Settings'),
            ),
      body: userProfileBody,
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
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
