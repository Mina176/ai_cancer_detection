// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserRole)
final userRoleProvider = UserRoleProvider._();

final class UserRoleProvider extends $NotifierProvider<UserRole, String?> {
  UserRoleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRoleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRoleHash();

  @$internal
  @override
  UserRole create() => UserRole();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$userRoleHash() => r'63419b5eb68721ffdb20c439b13f2a85316d3a09';

abstract class _$UserRole extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
