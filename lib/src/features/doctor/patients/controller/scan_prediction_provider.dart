import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_prediction_provider.g.dart';

@Riverpod()
Future<ScanPredictionModel?> scanPrediction(Ref ref, UuidValue scanId) async {
  return client.medicalScan.getScanPrediction(scanId);
}
