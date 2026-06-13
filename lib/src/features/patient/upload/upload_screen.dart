import 'dart:typed_data';
import 'package:cancer_ai_detection/src/common_widgets/sticky_button_with_scroll_body.dart';
import 'package:cancer_ai_detection/src/features/patient/upload/widgets/scan_data_form.dart';
import 'package:cancer_ai_detection/src/features/patient/upload/widgets/upload_scan_section.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/primary_button.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Uint8List? selectedFileBytes;
  String? selectedFileName;
  DateTime selectedDate = DateTime.now();
  ScanType selectedScanType = ScanType.mri;
  BodyPart selectedBodyPart = BodyPart.head;
  Future<void> pickScanFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const [
        'dcm',
        'dicom',
      ],
      withData: true,
    );
    final pickedFile = result?.files.single;
    if (pickedFile?.bytes != null) {
      setState(() {
        selectedFileBytes = pickedFile!.bytes;
        selectedFileName = pickedFile.name;
      });
    }
  }

  Future<void> uploadScan() async {
    try {
      if (selectedFileBytes != null) {
        final ByteData imageByteData = ByteData.view(
          selectedFileBytes!.buffer,
        );
        await client.medicalScan.uploadMyScan(
          imageByteData,
          scanType: selectedScanType,
          bodyPart: selectedBodyPart,
          scanDate: selectedDate,
        );
      }
      if (mounted) {
        context.goNamed(AppRoute.home.name);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading scan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Upload Scan'),
            ),
      body: context.isLandscape
          ? Row(
              children: [
                Expanded(
                  flex: 6,
                  child: UploadScanSection(
                    fileBytes: selectedFileBytes,
                    fileName: selectedFileName,
                    onPickFile: pickScanFile,
                    onCancel: () => setState(() {
                      selectedFileBytes = null;
                      selectedFileName = null;
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.kHorizontalPadding,
                        ),
                        child: PrimaryButton(
                          onPressed: () => uploadScan(),
                          label: 'Upload',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          // mobile layout
          : StickyButtonWithScrollBody(
              onButtonPressed: uploadScan,
              buttonLabel: 'Upload',
              children: [
                UploadScanSection(
                  fileBytes: selectedFileBytes,
                  fileName: selectedFileName,
                  onPickFile: pickScanFile,
                  onCancel: () => setState(() {
                    selectedFileBytes = null;
                    selectedFileName = null;
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
    );
  }
}
