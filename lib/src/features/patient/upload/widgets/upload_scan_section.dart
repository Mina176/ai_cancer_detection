import 'dart:typed_data';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:cancer_ai_detection/src/features/patient/upload/widgets/upload_card.dart';
import 'package:flutter/material.dart';

class UploadScanSection extends StatelessWidget {
  const UploadScanSection({
    super.key,
    required this.fileBytes,
    required this.fileName,
    required this.onPickFile,
    required this.onCancel,
  });

  final Uint8List? fileBytes;
  final String? fileName;
  final VoidCallback onPickFile;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return context.isLandscape
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.kVerticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.kHorizontalPadding,
                  ),
                  child: Text(
                    'Upload Diagnostic Scan',
                    style: context.displaySmall?.extraBold,
                  ),
                ),
                4.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.kHorizontalPadding,
                  ),
                  child: Text(
                    'Upload patient imaging files for AI-assisted diagnostic analysis.',
                    style: context.bodyLarge?.copyWith(
                      color: context.theme.hintColor,
                    ),
                  ),
                ),
                32.heightBox,
                UploadCard(
                  fileBytes: fileBytes,
                  fileName: fileName,
                  onPickFile: onPickFile,
                  onCancel: onCancel,
                ),
              ],
            ),
          )
        : UploadCard(
            fileBytes: fileBytes,
            fileName: fileName,
            onPickFile: onPickFile,
            onCancel: onCancel,
          );
  }
}
