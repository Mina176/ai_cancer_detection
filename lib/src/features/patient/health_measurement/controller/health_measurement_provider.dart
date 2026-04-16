import 'package:cancer_ai_detection/main.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';

part 'health_measurement_provider.g.dart';

@Riverpod()
@JsonPersist()
class HealthMeasurement extends _$HealthMeasurement {
  @override
  FutureOr<List<HealthMeasurementModel>> build() async {
    return await client.healthMeasurement.list();
  }
}
