import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_role_provider.g.dart';

@Riverpod()
class UserRole extends _$UserRole {
  @override
  String? build() {
    return null;
  }

  void setRole(String role) {
    state = role;
  }
}
