import 'dart:typed_data';

import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:file_picker/file_picker.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/primary_button.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_patients_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/upload/widgets/scan_data_form.dart';
import 'package:cancer_ai_detection/src/features/patient/upload/widgets/upload_scan_section.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class LabAddScanScreen extends ConsumerStatefulWidget {
  const LabAddScanScreen({
    super.key,
    required this.patientId,
  });

  final UuidValue patientId;

  @override
  ConsumerState<LabAddScanScreen> createState() => _LabAddScanScreenState();
}

class _LabAddScanScreenState extends ConsumerState<LabAddScanScreen> {
  Uint8List? selectedFileBytes;
  String? selectedFileName;

  DateTime selectedDate = DateTime.now();
  ScanType selectedScanType = ScanType.mri;
  BodyPart selectedBodyPart = BodyPart.head;
  bool isUploading = false;

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
    if (selectedFileBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a scan file first.')),
      );
      return;
    }

    setState(() => isUploading = true);
    try {
      final ByteData imageByteData = ByteData.view(selectedFileBytes!.buffer);
      await client.lab.addScan(
        widget.patientId,
        imageByteData,
        selectedScanType,
        selectedBodyPart,
        selectedDate,
        null,
      );
      if (!mounted) return;
      ref.invalidate(labPatientsProvider);
      GoRouter.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading scan: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(title: const Text('Upload Scan for Patient')),
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
                          onPressed: uploadScan,
                          label: isUploading ? 'Uploading...' : 'Upload',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.kHorizontalPadding,
                  ),
                  child: PrimaryButton(
                    onPressed: uploadScan,
                    label: isUploading ? 'Uploading...' : 'Upload',
                  ),
                ),
              ],
            ),
    );
  }
}
