import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'list_my_doctors.g.dart';

@riverpod
Future<List<PatientDoctorModel>> listMyDoctors(Ref ref) async {
  return client.patientDoctor.listMyDoctors();
}
