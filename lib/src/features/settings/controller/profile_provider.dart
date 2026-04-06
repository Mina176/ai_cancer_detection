import 'package:cancer_ai_detection/src/utils/storage/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:cancer_ai_detection/main.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserProfileModel> build() async {
    persist(
      ref.watch(storageProvider.future),
      key: 'user_profile',
      encode: (profile) => profile.toJson(),
      decode: (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
    );

    return await client.userProfileEdit.get();
  }
}
