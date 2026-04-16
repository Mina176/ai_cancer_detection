import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/generic_list_screen.dart';
import 'package:cancer_ai_detection/src/common_widgets/swipe_to_delete_wrapper.dart';
import 'package:cancer_ai_detection/src/features/doctor/diagnoses/controller/patient_diagnoses_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class PatientDiagnosesScreen extends ConsumerWidget {
  const PatientDiagnosesScreen({super.key, required this.patientId});

  final UuidValue patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosesAsync = ref.watch(patientDiagnosesProvider(patientId));

    return GenericListScreen<DiagnosisModel>(
      title: 'Patient Diagnoses',
      asyncData: diagnosesAsync,
      onAddPressed: () => GoRouter.of(context).pushNamed(
        AppRoute.addDiagnosis.name,
        pathParameters: {'patientId': patientId.toString()},
      ),
      itemBuilder: (context, diagnosis) {
        return SwipeToDeleteWrapper(
          itemKey: ValueKey(diagnosis.id),
          child: Card(
            child: ListTile(
              title: Text(diagnosis.diagnosisText),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((diagnosis.icd10Code ?? '').isNotEmpty)
                    Text('ICD-10: ${diagnosis.icd10Code}'),
                  if ((diagnosis.notes ?? '').isNotEmpty)
                    Text(diagnosis.notes!),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(diagnosis.severity.name.toUpperCase()),
                  6.heightBox,
                  Text(
                    diagnosis.createdAt == null
                        ? '-'
                        : DateFormat('d/M/y').format(diagnosis.createdAt!),
                  ),
                ],
              ),
            ),
          ),
          onConfirmDelete: () async {
            try {
              final diagnosisId = diagnosis.id;
              if (diagnosisId == null) return false;

              await client.diagnosis.delete(diagnosisId);
              ref.invalidate(patientDiagnosesProvider(patientId));
              return true;
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete diagnosis: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return false;
            }
          },
        );
      },
    );
  }
}
