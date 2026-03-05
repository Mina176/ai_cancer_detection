import 'dart:io';
import 'dart:typed_data';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/upload/presentation/scan_data_form.dart';
import 'package:cancer_ai_detection/features/upload/presentation/upload_scan_section.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? selectedXFile;
  Uint8List? webImageBytes;
  final ImagePicker picker = ImagePicker();
  DateTime selectedDate = DateTime.now();
  ScanType selectedScanType = ScanType.mri;
  BodyPart selectedBodyPart = BodyPart.head;

  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        selectedXFile = pickedFile;
        webImageBytes = bytes;
      });
    }
  }

  void uploadScan() async {
    if (webImageBytes != null) {
      final ByteData imageByteData = ByteData.view(webImageBytes!.buffer);
      await client.medicalScan.uploadMyScan(
        imageByteData,
        scanType: selectedScanType,
        bodyPart: selectedBodyPart,
        scanDate: selectedDate,
      );
      print('Scan uploaded successfully');
    }
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
                  child: UploadScanSection(
                    imageBytes: webImageBytes,
                    onPickImage: pickImage,
                    onCancel: () => setState(() {
                      selectedXFile = null;
                      webImageBytes = null;
                    }),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: ScanDataForm(
                          scanType: selectedScanType,
                          bodyPart: selectedBodyPart,
                          onScanChanged: (value) {
                            setState(() {
                              selectedScanType = value!;
                            });
                          },
                          onBodyPartChanged: (value) {
                            setState(() {
                              selectedBodyPart = value!;
                            });
                          },
                          selectedDate: selectedDate,
                          onSelectDate: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                      ),
                      StickyUploadButton(onPressed: uploadScan),
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
                          imageBytes: webImageBytes,
                          onPickImage: pickImage,
                          onCancel: () => setState(() {
                            selectedXFile = null;
                            webImageBytes = null;
                          }),
                        ),
                        ScanDataForm(
                          scanType: selectedScanType,
                          bodyPart: selectedBodyPart,
                          onScanChanged: (value) {
                            setState(() {
                              selectedScanType = value!;
                            });
                          },
                          onBodyPartChanged: (value) {
                            setState(() {
                              selectedBodyPart = value!;
                            });
                          },
                          selectedDate: selectedDate,
                          onSelectDate: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                StickyUploadButton(onPressed: uploadScan),
              ],
            ),
    );
  }
}
