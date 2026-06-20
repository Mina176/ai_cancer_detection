import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/features/doctor/patients/controller/patient_details_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class PatientScansScreen extends ConsumerWidget {
  const PatientScansScreen({super.key, required this.patientId});
  final UuidValue patientId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientDetailsProvider(patientId));
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(title: const Text('Patient Scans')),
      body: patientAsync.when(
        data: (patient) {
          final scans = [
            MedicalScanModel(
              patientProfileId: patientId,
              scanType: ScanType.ct,
              bodyPart: BodyPart.chest,
              scanDate: DateTime.now(),
            ),
          ];
          if (scans.isEmpty) return const EmptyScansState();
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: scans.length,
            separatorBuilder: (_, _) => 12.heightBox,
            itemBuilder: (context, index) =>
                ScanCard(scan: scans[index], patientId: patientId),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class EmptyScansState extends StatelessWidget {
  const EmptyScansState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_off_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          16.heightBox,
          Text(
            'No scans found for this patient.',
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class ScanCard extends StatelessWidget {
  const ScanCard({
    super.key,
    required this.scan,
    required this.patientId,
  });

  final MedicalScanModel scan;
  final UuidValue patientId;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.document_scanner_rounded,
            color: context.theme.primaryColor,
          ),
        ),
        title: Text(
          scan.scanType.name,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            DateFormat(' d/M/y').format(scan.scanDate),
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey.shade400,
        ),
        onTap: () => context.pushNamed(
          AppRoute.scan.name,
          extra: scan,
        ),
      ),
    );
  }
}
