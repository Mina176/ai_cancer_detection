import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_diagnoses_provider.g.dart';

@riverpod
Future<List<DiagnosisModel>> patientDiagnoses(
  Ref ref,
  String patientId,
) async {
  final normalizedPatientId = patientId.trim();
  if (normalizedPatientId.isEmpty) {
    return [];
  }

  final parsedPatientId = UuidValue.fromString(normalizedPatientId);
  return client.diagnosis.list(parsedPatientId);
}
