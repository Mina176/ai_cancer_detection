import 'package:cancer_ai_detection/src/utils/storage/shared_prefs/shared_prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_completed_profile.g.dart';

@Riverpod(keepAlive: true)
class HasCompletedProfile extends _$HasCompletedProfile {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool('isProfileDone') ?? false;
  }

  void markAsComplete() {
    ref.read(sharedPreferencesProvider).setBool('isProfileDone', true);
    state = true;
  }
}
