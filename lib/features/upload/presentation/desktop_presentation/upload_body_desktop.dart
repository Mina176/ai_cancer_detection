import 'dart:io';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/upload/data/prediction.dart';
import 'package:cancer_ai_detection/features/upload/presentation/desktop_presentation/scan_data_section.dart';
import 'package:cancer_ai_detection/features/upload/presentation/desktop_presentation/upload_scan_section.dart';
import 'package:cancer_ai_detection/features/upload/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadBodyDesktop extends StatefulWidget {
  const UploadBodyDesktop({super.key});

  @override
  State<UploadBodyDesktop> createState() => _UploadBodyDesktopState();
}

class _UploadBodyDesktopState extends State<UploadBodyDesktop> {
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
            selectedImage: selectedImage,
            isLoading: isLoading,
            onPickImage: pickImage,
          ).expanded(flex: 6),
          VerticalDivider(width: 1),
          ScanDataSection(
            result: result,
            isLoading: isLoading,
            onProcessImage: processImage,
            onCancel: () {
              setState(() {
                selectedImage = null;
                result = null;
              });
            },
          ).expanded(flex: 3),
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
