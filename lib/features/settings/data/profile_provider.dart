import 'package:cancer_ai_detection/utils/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

final userProfileProvider =
    AsyncNotifierProvider<UserProfileModelNotifier, UserProfileModel>(
      UserProfileModelNotifier.new,
    );

class UserProfileModelNotifier extends AsyncNotifier<UserProfileModel> {
  @override
  Future<UserProfileModel> build() async {
    persist(
      ref.watch(storageProvider.future),
      key: 'user_profile',

      encode: (profile) => profile.toJson(),

      decode: (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
    );

    return client.userProfileEdit.get();
  }
}
