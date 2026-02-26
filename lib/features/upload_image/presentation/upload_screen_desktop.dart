import 'dart:io';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/features/upload_image/data/prediction.dart';
import 'package:cancer_ai_detection/features/upload_image/presentation/patient_data_section.dart';
import 'package:cancer_ai_detection/features/upload_image/presentation/result.dart';
import 'package:cancer_ai_detection/features/upload_image/presentation/upload_image_section.dart';
import 'package:cancer_ai_detection/features/upload_image/service/api_service.dart';
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

  Future<void> pickImage() async {
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

  Future<void> processImage() async {
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
      body: Row(
        children: [
          UploadImageSection(
            selectedImage: selectedImage,
            isLoading: isLoading,
            onPickImage: pickImage,
            onProcessImage: processImage,
          ).expanded(flex: 5),
          PatientDataSection().expanded(flex: 2),
        ],
      ),
    );
  }
}
