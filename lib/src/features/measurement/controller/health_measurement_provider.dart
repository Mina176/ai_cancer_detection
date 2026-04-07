import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/utils/storage/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';

part 'health_measurement_provider.g.dart';

@Riverpod(keepAlive: true)
@JsonPersist()
class HealthMeasurement extends _$HealthMeasurement {
  @override
  FutureOr<List<HealthMeasurementModel>> build() async {
    await persist(
      ref.watch(storageProvider.future),
    ).future;
    return await client.healthMeasurement.list();
  }
}
