import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/common_widgets/profile_image.dart';
import 'package:cancer_ai_detection/src/features/patient/patient_doctor/controller/select_doctor_controller.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class PatientSettingsLayout extends StatelessWidget {
  const PatientSettingsLayout({
    super.key,
    required this.context,
    required this.ref,
    required this.profile,
    required this.allergiesAsync,
    required this.medicationsAsync,
    required this.medicalHistoryAsync,
    required this.healthMeasurementsAsync,
    required this.patientDoctorAsync,
    required this.formatEnumLabel,
  });

  final BuildContext context;
  final WidgetRef ref;
  final PatientProfileModel profile;
  final AsyncValue allergiesAsync;
  final AsyncValue medicationsAsync;
  final AsyncValue medicalHistoryAsync;
  final AsyncValue healthMeasurementsAsync;
  final AsyncValue<SelectDoctorViewState> patientDoctorAsync;
  final String Function(dynamic value, {String fallback}) formatEnumLabel;

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
                            context.pushNamed(AppRoute.patientForm.name),
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
                          if (data.filteredYourDoctors.isEmpty) {
                            return const Text('None added yet');
                          }
                          return Text(
                            data.filteredYourDoctors
                                .map(
                                  (patientDoctor) => patientDoctor.fullName!,
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
