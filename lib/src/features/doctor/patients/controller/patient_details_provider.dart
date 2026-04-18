import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_details_provider.g.dart';

@Riverpod()
Future<PatientProfileModel> patientDetails(Ref ref, UuidValue patientId) async {
  return client.patient.getPatient(patientId);
}

@Riverpod()
Future<String> generatePatientAnalysis(Ref ref, UuidValue patientId) async {
  return client.patient.generatePatientAnalysis(patientId);
}
