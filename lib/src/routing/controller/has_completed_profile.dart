import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_completed_profile.g.dart';

@Riverpod(keepAlive: true)
class HasCompletedProfile extends _$HasCompletedProfile {
  @override
  bool build() => false;

  void markAsComplete() => state = true;
}
