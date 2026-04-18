// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_patients_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(labPatients)
final labPatientsProvider = LabPatientsProvider._();

final class LabPatientsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PatientProfileModel>>,
          List<PatientProfileModel>,
          FutureOr<List<PatientProfileModel>>
        >
    with
        $FutureModifier<List<PatientProfileModel>>,
        $FutureProvider<List<PatientProfileModel>> {
  LabPatientsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labPatientsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labPatientsHash();

  @$internal
  @override
  $FutureProviderElement<List<PatientProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PatientProfileModel>> create(Ref ref) {
    return labPatients(ref);
  }
}

String _$labPatientsHash() => r'8a08a7ae30256517a51e4c39faa6b1ef32dd40cd';
