import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'select_doctors_provider.g.dart';

@riverpod
Future<List<DoctorProfileModel>> selectDoctors(Ref ref) async {
  return client.doctorProfile.getAllDoctors();
}
