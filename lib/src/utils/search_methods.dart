import 'package:gp_backend_client/gp_backend_client.dart';

extension DoctorListFilter on List<DoctorProfileModel> {
  List<DoctorProfileModel> filterBySearch(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return this;

    return where(
      (d) =>
          (d.fullName?.toLowerCase() ?? '').contains(q) ||
          d.authUserId.toString().toLowerCase().contains(q),
    ).toList();
  }
}

extension PatientDoctorListFilter on List<PatientDoctorModel> {
  List<PatientDoctorModel> filterBySearch(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return this;

    return where(
      (d) =>
          (d.doctor?.fullName?.toLowerCase() ?? '').contains(q) ||
          d.doctorId.toString().toLowerCase().contains(q),
    ).toList();
  }
}

extension LabListFilter on List<LabProfileModel> {
  List<LabProfileModel> filterBySearch(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return this;

    return where(
      (d) =>
          (d.name?.toLowerCase() ?? '').contains(q) ||
          d.authUserId.toString().toLowerCase().contains(q),
    ).toList();
  }
}

extension PatientListFilter on List<PatientProfileModel> {
  List<PatientProfileModel> filterBySearch(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return this;

    return where(
      (p) =>
          // Assuming PatientProfileModel has fullName and authUserId
          (p.fullName?.toLowerCase() ?? '').contains(q) ||
          p.authUserId.toString().toLowerCase().contains(q),
    ).toList();
  }
}
