import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_provider.g.dart';

@Riverpod()
Future<List<PatientProfileModel>> patients(Ref ref) async {
  return await client.patient.listPatients(limit: 30, offset: 0);
}
