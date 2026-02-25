import 'package:cancer_ai_detection/data/prediction.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({super.key, required this.result});
  final Prediction? result;

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return const Center(child: Text("Upload an image and tap Analyze"));
    }
    if (result!.errorMessage != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        color: Colors.red.shade100,
        child: Text(
          result!.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "AI Prediction:",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              result!.result,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
