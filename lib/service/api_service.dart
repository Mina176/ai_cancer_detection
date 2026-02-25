import 'dart:io';
import 'package:cancer_ai_detection/data/prediction.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://gp.5274336.xyz';
  static const String endpoint = '$baseUrl/predict';

  Future<Prediction> analyzeXray(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(endpoint));

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return Prediction.fromString(responseData);
      } else if (response.statusCode == 422) {
        return Prediction.withError(
          'Validation Error (422): The API rejected the format.\nDetails: $responseData',
        );
      } else {
        return Prediction.withError('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      return Prediction.withError(
        'Failed to connect to the API. Check your internet connection.',
      );
    }
  }
}
