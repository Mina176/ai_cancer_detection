import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/utils/search_methods.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_controller.g.dart';

@riverpod
class PatientSearchQuery extends _$PatientSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

@riverpod
Future<List<PatientProfileModel>> patients(Ref ref) async {
  return await client.patient.listPatients(limit: 30, offset: 0);
}

@riverpod
AsyncValue<List<PatientProfileModel>> filteredPatients(Ref ref) {
  final query = ref.watch(patientSearchQueryProvider);
  final patientsAsync = ref.watch(patientsProvider);

  return patientsAsync.whenData((patients) => patients.filterBySearch(query));
}
