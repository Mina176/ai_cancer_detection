// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'has_completed_profile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HasCompletedProfile)
final hasCompletedProfileProvider = HasCompletedProfileProvider._();

final class HasCompletedProfileProvider
    extends $NotifierProvider<HasCompletedProfile, bool> {
  HasCompletedProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasCompletedProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasCompletedProfileHash();

  @$internal
  @override
  HasCompletedProfile create() => HasCompletedProfile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasCompletedProfileHash() =>
    r'd3c92d30347fc77a57e8cdcc1f003c6983b4eea2';

abstract class _$HasCompletedProfile extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
