import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'allergies_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<AllergyModel>> allergies(Ref ref) async {
  return client.allergy.listMyAllergies();
}
