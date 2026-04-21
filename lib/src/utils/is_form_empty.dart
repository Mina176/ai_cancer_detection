import 'package:gp_backend_client/gp_backend_client.dart';

bool isPatientFormEmpty(PatientProfileModel profile) {
  return isEmpty(profile.fullName) &&
      profile.dob == null &&
      profile.gender == null &&
      profile.bloodType == null &&
      isEmpty(profile.smokingStatus) &&
      profile.smokingYears == null &&
      isEmpty(profile.alcoholFreq) &&
      isEmpty(profile.exerciseFreq);
}

bool isDoctorFormEmpty(DoctorProfileModel profile) {
  return isEmpty(profile.fullName) &&
      isEmpty(profile.specialization) &&
      isEmpty(profile.bio) &&
      isEmpty(profile.hospitalName) &&
      isEmpty(profile.licenseNumber) &&
      isEmpty(profile.phone) &&
      isEmpty(profile.yearsOfExperience?.toString());
}

bool isLabFormEmpty(LabProfileModel profile) {
  return isEmpty(profile.address) &&
      isEmpty(profile.labType) &&
      isEmpty(profile.name) &&
      isEmpty(profile.phone);
}

bool isEmpty(dynamic value) {
  if (value == null) return true;
  if (value is String) return value.trim().isEmpty;
  return false;
}
