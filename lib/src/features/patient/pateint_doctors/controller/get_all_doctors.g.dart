// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_doctors.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllDoctors)
final getAllDoctorsProvider = GetAllDoctorsProvider._();

final class GetAllDoctorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DoctorProfileModel>>,
          List<DoctorProfileModel>,
          FutureOr<List<DoctorProfileModel>>
        >
    with
        $FutureModifier<List<DoctorProfileModel>>,
        $FutureProvider<List<DoctorProfileModel>> {
  GetAllDoctorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllDoctorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllDoctorsHash();

  @$internal
  @override
  $FutureProviderElement<List<DoctorProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DoctorProfileModel>> create(Ref ref) {
    return getAllDoctors(ref);
  }
}

String _$getAllDoctorsHash() => r'3a6709091e823f9c1aa96f82abcb7eeb87c861d6';
