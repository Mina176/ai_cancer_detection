import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:cancer_ai_detection/main.dart';

part 'profile_provider.g.dart';

@Riverpod()
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserProfileModel> build() async {
    return await client.userProfileEdit.get();
  }
}
