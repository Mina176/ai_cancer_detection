// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(labProfile)
final labProfileProvider = LabProfileProvider._();

final class LabProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<LabProfileModel>,
          LabProfileModel,
          FutureOr<LabProfileModel>
        >
    with $FutureModifier<LabProfileModel>, $FutureProvider<LabProfileModel> {
  LabProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labProfileHash();

  @$internal
  @override
  $FutureProviderElement<LabProfileModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LabProfileModel> create(Ref ref) {
    return labProfile(ref);
  }
}

String _$labProfileHash() => r'e6127952304071b517ce60619504a3706be4ca4d';
