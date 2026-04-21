// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_lab_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectLabController)
final selectLabControllerProvider = SelectLabControllerProvider._();

final class SelectLabControllerProvider
    extends $AsyncNotifierProvider<SelectLabController, SelectLabViewState> {
  SelectLabControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectLabControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectLabControllerHash();

  @$internal
  @override
  SelectLabController create() => SelectLabController();
}

String _$selectLabControllerHash() =>
    r'125982a0596375615221595253390de8d58c4ab5';

abstract class _$SelectLabController
    extends $AsyncNotifier<SelectLabViewState> {
  FutureOr<SelectLabViewState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SelectLabViewState>, SelectLabViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SelectLabViewState>, SelectLabViewState>,
              AsyncValue<SelectLabViewState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
