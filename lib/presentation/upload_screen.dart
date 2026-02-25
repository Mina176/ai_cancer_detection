import 'dart:io';
import 'package:cancer_ai_detection/data/prediction.dart';
import 'package:cancer_ai_detection/presentation/result.dart';
import 'package:cancer_ai_detection/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? selectedImage;
  bool isLoading = false;
  Prediction? result;

  final ImagePicker picker = ImagePicker();
  final ApiService apiService = ApiService();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 224,
      maxHeight: 224,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        result = null;
      });
    }
  }

  Future<void> _processImage() async {
    if (selectedImage == null) return;

    setState(() {
      isLoading = true;
    });

    Prediction prediction = await apiService.analyzeXray(selectedImage!);

    setState(() {
      result = prediction;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lung Cancer X-Ray AI'),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              selectedImage != null
                  ? Image.file(selectedImage!, fit: BoxFit.contain)
                  : const Center(
                      child: Icon(Icons.image, size: 100, color: Colors.grey),
                    ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text("Select X-Ray"),
                  ),
                  ElevatedButton.icon(
                    onPressed: isLoading || selectedImage == null
                        ? null
                        : _processImage,
                    icon: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.analytics),
                    label: const Text("Analyze"),
                  ),
                ],
              ),
              Result(result: result),
            ],
          ),
        ),
      ),
    );
  }
}
