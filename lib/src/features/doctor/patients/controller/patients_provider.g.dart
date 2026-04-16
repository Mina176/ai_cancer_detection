// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patients)
final patientsProvider = PatientsProvider._();

final class PatientsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PatientProfileModel>>,
          List<PatientProfileModel>,
          FutureOr<List<PatientProfileModel>>
        >
    with
        $FutureModifier<List<PatientProfileModel>>,
        $FutureProvider<List<PatientProfileModel>> {
  PatientsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'patientsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$patientsHash();

  @$internal
  @override
  $FutureProviderElement<List<PatientProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PatientProfileModel>> create(Ref ref) {
    return patients(ref);
  }
}

String _$patientsHash() => r'7de4af254680817296de1b61b2c79cc76de27224';
