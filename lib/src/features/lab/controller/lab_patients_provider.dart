import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lab_patients_provider.g.dart';

@Riverpod()
Future<List<PatientProfileModel>> labPatients(Ref ref) async {
  return client.lab.listMyPatients(limit: 30, offset: 0);
}
