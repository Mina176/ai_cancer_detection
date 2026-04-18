// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_doctors_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientDoctors)
final patientDoctorsProvider = PatientDoctorsProvider._();

final class PatientDoctorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PatientDoctorModel>>,
          List<PatientDoctorModel>,
          FutureOr<List<PatientDoctorModel>>
        >
    with
        $FutureModifier<List<PatientDoctorModel>>,
        $FutureProvider<List<PatientDoctorModel>> {
  PatientDoctorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'patientDoctorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$patientDoctorsHash();

  @$internal
  @override
  $FutureProviderElement<List<PatientDoctorModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PatientDoctorModel>> create(Ref ref) {
    return patientDoctors(ref);
  }
}

String _$patientDoctorsHash() => r'd4e8b83e0e93a67c52bbe0e17609dc0b8ae1e1e7';
