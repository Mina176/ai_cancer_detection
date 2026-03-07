// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(medications)
final medicationsProvider = MedicationsProvider._();

final class MedicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MedicationModel>>,
          List<MedicationModel>,
          FutureOr<List<MedicationModel>>
        >
    with
        $FutureModifier<List<MedicationModel>>,
        $FutureProvider<List<MedicationModel>> {
  MedicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationseHash();

  @$internal
  @override
  $FutureProviderElement<List<MedicationModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MedicationModel>> create(Ref ref) {
    return medications(ref);
  }
}

String _$medicationseHash() => r'b19f34a0a4e79d5473da54558b2bc4e0b53fe6fd';
