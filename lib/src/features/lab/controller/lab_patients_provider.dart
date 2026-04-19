import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lab_patients_provider.g.dart';

@Riverpod()
Future<List<PatientProfileModel>> labPatients(Ref ref) async {
  return client.lab.listMyPatients(limit: 30, offset: 0);
}

class LabPatientsPageRequest {
  const LabPatientsPageRequest({required this.limit, required this.offset});

  final int limit;
  final int offset;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LabPatientsPageRequest &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(limit, offset);
}

@Riverpod()
Future<List<PatientProfileModel>> labPatientsPage(
  Ref ref,
  LabPatientsPageRequest request,
) async {
  return client.lab.listMyPatients(
    limit: request.limit,
    offset: request.offset,
  );
}
