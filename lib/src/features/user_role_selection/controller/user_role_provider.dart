import 'package:cancer_ai_detection/src/utils/storage/shared_prefs/shared_prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_role_provider.g.dart';

@Riverpod(keepAlive: true)
String? userRole(Ref ref) {
  return ref.watch(sharedPreferencesProvider).getString('userRole');
}
