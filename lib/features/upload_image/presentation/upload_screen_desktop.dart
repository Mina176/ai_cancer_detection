import 'dart:io';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/upload/data/prediction.dart';
import 'package:cancer_ai_detection/features/upload/presentation/scan_data_form.dart';
import 'package:cancer_ai_detection/features/upload/presentation/upload_scan_section.dart';
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

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          UploadScanSection(
            onCancel: () {},
            selectedImage: selectedImage,
            onPickImage: pickImage,
          ).expanded(flex: 6),
          VerticalDivider(width: 1),
          ScanDataForm().expanded(flex: 3),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
          vertical: Sizes.kVerticalPadding,
        ),
        child: Row(
          children: [
            Text(
              'Cancer AI Detection',
              style: context.headlineMedium?.extraBold,
            ),
            Spacer(),
            Text(
              'Upload and Analyze Diagnostic Scans',
              style: context.bodyMedium?.copyWith(
                color: context.theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
