import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/features/lab/controller/lab_patients_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class LabPatientsScreen extends ConsumerWidget {
  const LabPatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsyncValue = ref.watch(labPatientsProvider);

    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Assigned Patients'),
            ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.kVerticalPadding,
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patients Assigned',
                  style: context.headlineMedium?.bold,
                ),
                patientsAsyncValue.when(
                  data: (patients) {
                    if (patients.isEmpty) {
                      return const Center(
                        child: Text('No assigned patients found.'),
                      );
                    }
                    return Expanded(
                      child: ListView.separated(
                        itemCount: patients.length,
                        separatorBuilder: (context, index) => 8.heightBox,
                        itemBuilder: (context, index) {
                          final patient = patients[index];
                          return _PatientActionsCard(patient: patient);
                        },
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Text('Error loading patients: $error'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PatientActionsCard extends StatelessWidget {
  const _PatientActionsCard({required this.patient});

  final PatientProfileModel patient;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patient.fullName ?? 'Unknown Patient',
              style: context.titleMedium?.bold,
            ),
            10.heightBox,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.labAddHealthMeasurement.name,
                      pathParameters: {
                        'patientId': patient.id.toString(),
                      },
                    );
                  },
                  icon: const Icon(Icons.monitor_heart_rounded),
                  label: const Text('Add Health Measurement'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.labAddScan.name,
                      pathParameters: {
                        'patientId': patient.id.toString(),
                      },
                    );
                  },
                  icon: const Icon(Icons.upload_file_rounded),
                  label: const Text('Upload Scan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
