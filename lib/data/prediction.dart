class Prediction {
  final String result;
  final String? errorMessage;

  Prediction({required this.result, this.errorMessage});

  factory Prediction.fromString(String rawResponse) {
    String cleaned = rawResponse.replaceAll('\n', ',').replaceAll('"', '');

    double parsedConfidence = 0.0;
    RegExp probRegex = RegExp(r'probability:([0-9.]+)');
    var match = probRegex.firstMatch(cleaned);

    if (match != null) {
      String probStr = match.group(1) ?? '0';
      parsedConfidence = double.tryParse(probStr) ?? 0.0;
    }
    String percentageText = "${(parsedConfidence * 100).toStringAsFixed(1)}%";
    String finalResult = "Unknown Result\nConfidence: $percentageText";
    if (cleaned.contains('prediction:with_cancer')) {
      finalResult = "Cancer Detected\nConfidence: $percentageText";
    } else if (cleaned.contains('without_cancer')) {
      finalResult = "No Cancer Detected\nConfidence: $percentageText";
    }
    return Prediction(result: finalResult);
  }

  factory Prediction.withError(String message) {
    return Prediction(result: 'Error', errorMessage: message);
  }
}
