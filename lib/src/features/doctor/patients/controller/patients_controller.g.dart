// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PatientSearchQuery)
final patientSearchQueryProvider = PatientSearchQueryProvider._();

final class PatientSearchQueryProvider
    extends $NotifierProvider<PatientSearchQuery, String> {
  PatientSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'patientSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$patientSearchQueryHash();

  @$internal
  @override
  PatientSearchQuery create() => PatientSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$patientSearchQueryHash() =>
    r'e6f9019f7cf872b0d8ad7db8df928294ef1c20de';

abstract class _$PatientSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

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

String _$patientsHash() => r'11dba0572ed46b52d3435079c3b33373ab69a8c8';

@ProviderFor(filteredPatients)
final filteredPatientsProvider = FilteredPatientsProvider._();

final class FilteredPatientsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PatientProfileModel>>,
          AsyncValue<List<PatientProfileModel>>,
          AsyncValue<List<PatientProfileModel>>
        >
    with $Provider<AsyncValue<List<PatientProfileModel>>> {
  FilteredPatientsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredPatientsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredPatientsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<PatientProfileModel>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<PatientProfileModel>> create(Ref ref) {
    return filteredPatients(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<PatientProfileModel>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<PatientProfileModel>>>(value),
    );
  }
}

String _$filteredPatientsHash() => r'3474fa5a51f6ca1a8ffa09488cc8c392592616f2';
