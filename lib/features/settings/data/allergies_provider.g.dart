// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(allergies)
final allergiesProvider = AllergiesProvider._();

final class AllergiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AllergyModel>>,
          List<AllergyModel>,
          FutureOr<List<AllergyModel>>
        >
    with
        $FutureModifier<List<AllergyModel>>,
        $FutureProvider<List<AllergyModel>> {
  AllergiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allergiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allergiesHash();

  @$internal
  @override
  $FutureProviderElement<List<AllergyModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AllergyModel>> create(Ref ref) {
    return allergies(ref);
  }
}

String _$allergiesHash() => r'84672bbb0635e3e384e674a0103adbeb3638871a';
