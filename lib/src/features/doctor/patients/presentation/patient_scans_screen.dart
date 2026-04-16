import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/controller/patient_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class PatientScansScreen extends ConsumerWidget {
  const PatientScansScreen({super.key, required this.patientId});
  final UuidValue patientId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientDetailsProvider(patientId));
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Patient Scans'),
            ),
      body: patientAsync.when(
        data: (patient) {
          final scans = patient.medicalScans ?? [];
          if (scans.isEmpty) {
            return const Center(
              child: Text('No scans found for this patient.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: scans.length,
            separatorBuilder: (context, index) => 8.heightBox,
            itemBuilder: (context, index) {
              final scan = scans[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.document_scanner_outlined),
                  title: Text(scan.toString()),
                  subtitle: scan is Map<String, dynamic>
                      ? Text(
                          'Type: ${scan.scanType}, Date: ${scan.scanDate.toString()}',
                        )
                      : null,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
