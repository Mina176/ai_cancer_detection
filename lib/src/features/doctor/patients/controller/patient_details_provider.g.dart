// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientDetails)
final patientDetailsProvider = PatientDetailsFamily._();

final class PatientDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PatientProfileModel>,
          PatientProfileModel,
          FutureOr<PatientProfileModel>
        >
    with
        $FutureModifier<PatientProfileModel>,
        $FutureProvider<PatientProfileModel> {
  PatientDetailsProvider._({
    required PatientDetailsFamily super.from,
    required UuidValue super.argument,
  }) : super(
         retry: null,
         name: r'patientDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$patientDetailsHash();

  @override
  String toString() {
    return r'patientDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PatientProfileModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PatientProfileModel> create(Ref ref) {
    final argument = this.argument as UuidValue;
    return patientDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientDetailsHash() => r'cf9dd90edbbbf1f12a40379b5de2e7e3b9df6214';

final class PatientDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PatientProfileModel>, UuidValue> {
  PatientDetailsFamily._()
    : super(
        retry: null,
        name: r'patientDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PatientDetailsProvider call(UuidValue patientId) =>
      PatientDetailsProvider._(argument: patientId, from: this);

  @override
  String toString() => r'patientDetailsProvider';
}
