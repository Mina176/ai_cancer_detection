import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'doctor_profile_provider.g.dart';

@Riverpod()
Future<DoctorProfileModel> doctorProfile(Ref ref) async {
  return await client.doctorProfile.getOrCreate();
}
