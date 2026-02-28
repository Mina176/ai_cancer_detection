import 'dart:io';
import 'dart:typed_data';
import 'package:cancer_ai_detection/features/upload/data/prediction.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class ServerpodApiService {
  final Client client;

  ServerpodApiService({required this.client});

  Future<PredictionResult?> analyzeXray(File imageFile) async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();

      final ByteData byteData = ByteData.view(bytes.buffer);

      final PredictionResult result = await client.prediction.predict(byteData);

      return result;
    } catch (e) {
      print('Failed to analyze image via Serverpod: $e');
      return null;
    }
  }
}
