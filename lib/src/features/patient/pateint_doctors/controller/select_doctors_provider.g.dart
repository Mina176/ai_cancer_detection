// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_doctors_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectDoctors)
final selectDoctorsProvider = SelectDoctorsProvider._();

final class SelectDoctorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DoctorProfileModel>>,
          List<DoctorProfileModel>,
          FutureOr<List<DoctorProfileModel>>
        >
    with
        $FutureModifier<List<DoctorProfileModel>>,
        $FutureProvider<List<DoctorProfileModel>> {
  SelectDoctorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectDoctorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectDoctorsHash();

  @$internal
  @override
  $FutureProviderElement<List<DoctorProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DoctorProfileModel>> create(Ref ref) {
    return selectDoctors(ref);
  }
}

String _$selectDoctorsHash() => r'1b6a2a44366d7f878725ca1f18d005aeeb5abfd1';
