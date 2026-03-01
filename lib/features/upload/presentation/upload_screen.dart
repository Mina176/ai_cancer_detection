import 'dart:io';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/upload/presentation/scan_data_form.dart';
import 'package:cancer_ai_detection/features/upload/presentation/sticky_upload_button.dart';
import 'package:cancer_ai_detection/features/upload/presentation/upload_scan_section.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void clearSelection() {
    setState(() {
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              forceMaterialTransparency: true,
              title: const Text('Upload Scan'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: context.isLandscape
          ? Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: UploadScanSection(
                      selectedImage: selectedImage,
                      onPickImage: pickImage,
                      onCancel: clearSelection,
                    ),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(child: const ScanDataForm()),
                      StickyUploadButton(onPressed: clearSelection),
                    ],
                  ),
                ),
              ],
            )
          // mobile layout
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UploadScanSection(
                          selectedImage: selectedImage,
                          onPickImage: pickImage,
                          onCancel: clearSelection,
                        ),
                        const ScanDataForm(),
                      ],
                    ),
                  ),
                ),
                StickyUploadButton(onPressed: clearSelection),
              ],
            ),
    );
  }
}
