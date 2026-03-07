// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserProfileNotifier)
final userProfileProvider = UserProfileModelNotifierProvider._();

final class UserProfileModelNotifierProvider
    extends $AsyncNotifierProvider<UserProfileNotifier, UserProfileModel> {
  UserProfileModelNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProfileModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userProfileModelNotifierHash();

  @$internal
  @override
  UserProfileNotifier create() => UserProfileNotifier();
}

String _$userProfileModelNotifierHash() =>
    r'c1368b94aa71877925a9eb9e48533f215bcd7f0b';

abstract class _$UserProfileNotifier extends $AsyncNotifier<UserProfileModel> {
  FutureOr<UserProfileModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UserProfileModel>, UserProfileModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfileModel>, UserProfileModel>,
              AsyncValue<UserProfileModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
