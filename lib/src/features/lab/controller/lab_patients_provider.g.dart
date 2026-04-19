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

@ProviderFor(labPatientsPage)
final labPatientsPageProvider = LabPatientsPageFamily._();

final class LabPatientsPageProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PatientProfileModel>>,
          List<PatientProfileModel>,
          FutureOr<List<PatientProfileModel>>
        >
    with
        $FutureModifier<List<PatientProfileModel>>,
        $FutureProvider<List<PatientProfileModel>> {
  LabPatientsPageProvider._({
    required LabPatientsPageFamily super.from,
    required LabPatientsPageRequest super.argument,
  }) : super(
         retry: null,
         name: r'labPatientsPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$labPatientsPageHash();

  @override
  String toString() {
    return r'labPatientsPageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PatientProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PatientProfileModel>> create(Ref ref) {
    final argument = this.argument as LabPatientsPageRequest;
    return labPatientsPage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LabPatientsPageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$labPatientsPageHash() => r'fc80a6be67d986a6d357daad13b1c202f7b541eb';

final class LabPatientsPageFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<PatientProfileModel>>,
          LabPatientsPageRequest
        > {
  LabPatientsPageFamily._()
    : super(
        retry: null,
        name: r'labPatientsPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LabPatientsPageProvider call(LabPatientsPageRequest request) =>
      LabPatientsPageProvider._(argument: request, from: this);

  @override
  String toString() => r'labPatientsPageProvider';
}
