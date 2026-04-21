// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_doctor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectDoctorController)
final selectDoctorControllerProvider = SelectDoctorControllerProvider._();

final class SelectDoctorControllerProvider
    extends
        $AsyncNotifierProvider<SelectDoctorController, SelectDoctorViewState> {
  SelectDoctorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectDoctorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectDoctorControllerHash();

  @$internal
  @override
  SelectDoctorController create() => SelectDoctorController();
}

String _$selectDoctorControllerHash() =>
    r'4c7edaa2a5364e74d439d1a64847bb8b2c75c88e';

abstract class _$SelectDoctorController
    extends $AsyncNotifier<SelectDoctorViewState> {
  FutureOr<SelectDoctorViewState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<SelectDoctorViewState>, SelectDoctorViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<SelectDoctorViewState>,
                SelectDoctorViewState
              >,
              AsyncValue<SelectDoctorViewState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
