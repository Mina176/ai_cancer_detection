import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'patient_doctors_provider.g.dart';

@riverpod
Future<List<PatientDoctorModel>> patientDoctors(Ref ref) async {
  return client.patientDoctor.listMyDoctors();
}
