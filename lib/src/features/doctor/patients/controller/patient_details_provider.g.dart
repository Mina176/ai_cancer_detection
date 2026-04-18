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

@ProviderFor(generatePatientAnalysis)
final generatePatientAnalysisProvider = GeneratePatientAnalysisFamily._();

final class GeneratePatientAnalysisProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  GeneratePatientAnalysisProvider._({
    required GeneratePatientAnalysisFamily super.from,
    required UuidValue super.argument,
  }) : super(
         retry: null,
         name: r'generatePatientAnalysisProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$generatePatientAnalysisHash();

  @override
  String toString() {
    return r'generatePatientAnalysisProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as UuidValue;
    return generatePatientAnalysis(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GeneratePatientAnalysisProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$generatePatientAnalysisHash() =>
    r'db87a08fc1daa57cbd7dea3ac1d1aef13765ba27';

final class GeneratePatientAnalysisFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, UuidValue> {
  GeneratePatientAnalysisFamily._()
    : super(
        retry: null,
        name: r'generatePatientAnalysisProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GeneratePatientAnalysisProvider call(UuidValue patientId) =>
      GeneratePatientAnalysisProvider._(argument: patientId, from: this);

  @override
  String toString() => r'generatePatientAnalysisProvider';
}
