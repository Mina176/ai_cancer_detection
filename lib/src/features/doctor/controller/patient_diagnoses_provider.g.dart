// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_diagnoses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(patientDiagnoses)
final patientDiagnosesProvider = PatientDiagnosesFamily._();

final class PatientDiagnosesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DiagnosisModel>>,
          List<DiagnosisModel>,
          FutureOr<List<DiagnosisModel>>
        >
    with
        $FutureModifier<List<DiagnosisModel>>,
        $FutureProvider<List<DiagnosisModel>> {
  PatientDiagnosesProvider._({
    required PatientDiagnosesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'patientDiagnosesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$patientDiagnosesHash();

  @override
  String toString() {
    return r'patientDiagnosesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DiagnosisModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DiagnosisModel>> create(Ref ref) {
    final argument = this.argument as String;
    return patientDiagnoses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientDiagnosesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientDiagnosesHash() => r'86bdfff8927de1daee83c51d57f66cd58f604fb0';

final class PatientDiagnosesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DiagnosisModel>>, String> {
  PatientDiagnosesFamily._()
    : super(
        retry: null,
        name: r'patientDiagnosesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PatientDiagnosesProvider call(String patientId) =>
      PatientDiagnosesProvider._(argument: patientId, from: this);

  @override
  String toString() => r'patientDiagnosesProvider';
}
