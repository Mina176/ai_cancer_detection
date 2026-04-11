import 'package:cancer_ai_detection/main.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';

part 'medical_history_provider.g.dart';

@Riverpod()
@JsonPersist()
class MedicalHistory extends _$MedicalHistory {
  @override
  FutureOr<List<MedicalHistoryModel>> build() async {
    return await client.medicalHistory.list();
  }
}
