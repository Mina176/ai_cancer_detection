// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(doctorProfile)
final doctorProfileProvider = DoctorProfileProvider._();

final class DoctorProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<DoctorProfileModel>,
          DoctorProfileModel,
          FutureOr<DoctorProfileModel>
        >
    with
        $FutureModifier<DoctorProfileModel>,
        $FutureProvider<DoctorProfileModel> {
  DoctorProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doctorProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doctorProfileHash();

  @$internal
  @override
  $FutureProviderElement<DoctorProfileModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DoctorProfileModel> create(Ref ref) {
    return doctorProfile(ref);
  }
}

String _$doctorProfileHash() => r'4a0d6bba290be07fbe129cfddfbf8d8dc6f6b4de';
