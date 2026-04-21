// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choose_doctor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChooseDoctorController)
final chooseDoctorControllerProvider = ChooseDoctorControllerProvider._();

final class ChooseDoctorControllerProvider
    extends
        $AsyncNotifierProvider<ChooseDoctorController, ChooseDoctorViewState> {
  ChooseDoctorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chooseDoctorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chooseDoctorControllerHash();

  @$internal
  @override
  ChooseDoctorController create() => ChooseDoctorController();
}

String _$chooseDoctorControllerHash() =>
    r'779e6a139db28c0b39b14d97f6af6934ef6af5bb';

abstract class _$ChooseDoctorController
    extends $AsyncNotifier<ChooseDoctorViewState> {
  FutureOr<ChooseDoctorViewState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ChooseDoctorViewState>, ChooseDoctorViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ChooseDoctorViewState>,
                ChooseDoctorViewState
              >,
              AsyncValue<ChooseDoctorViewState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
