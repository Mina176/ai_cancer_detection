// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_my_doctors.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listMyDoctors)
final listMyDoctorsProvider = ListMyDoctorsProvider._();

final class ListMyDoctorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PatientDoctorModel>>,
          List<PatientDoctorModel>,
          FutureOr<List<PatientDoctorModel>>
        >
    with
        $FutureModifier<List<PatientDoctorModel>>,
        $FutureProvider<List<PatientDoctorModel>> {
  ListMyDoctorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listMyDoctorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listMyDoctorsHash();

  @$internal
  @override
  $FutureProviderElement<List<PatientDoctorModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PatientDoctorModel>> create(Ref ref) {
    return listMyDoctors(ref);
  }
}

String _$listMyDoctorsHash() => r'943fc4c72a8dcd7dde33feb6cd93dc37c42f5463';
