// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientProfile)
final patientProfileProvider = PatientProfileProvider._();

final class PatientProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<PatientProfileModel>,
          PatientProfileModel,
          FutureOr<PatientProfileModel>
        >
    with
        $FutureModifier<PatientProfileModel>,
        $FutureProvider<PatientProfileModel> {
  PatientProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'patientProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$patientProfileHash();

  @$internal
  @override
  $FutureProviderElement<PatientProfileModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PatientProfileModel> create(Ref ref) {
    return patientProfile(ref);
  }
}

String _$patientProfileHash() => r'4700e93a95d8e7cf91bdb889540bf4f0f3c084cd';
