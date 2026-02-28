import 'dart:io';

import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/theming/app_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadScanSection extends StatelessWidget {
  const UploadScanSection({
    super.key,
    required this.selectedImage,
    required this.isLoading,
    required this.onPickImage,
  });

  final File? selectedImage;
  final bool isLoading;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Upload Diagnostic Scan', style: context.displaySmall?.extraBold),
        4.heightBox,
        Text(
          'Upload patient imaging files for AI-assisted diagnostic analysis.',
          style: context.bodyLarge?.copyWith(color: context.theme.hintColor),
        ),
        32.heightBox,
        UploadCard(
          selectedImage: selectedImage,
          onPickImage: onPickImage,
        ),
      ],
    ).paddingSymmetric(
      horizontal: Sizes.kHorizontalPadding,
      vertical: Sizes.kVerticalPadding,
    );
  }
}

class UploadCard extends StatelessWidget {
  const UploadCard({
    super.key,
    required this.selectedImage,
    required this.onPickImage,
  });

  final File? selectedImage;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    return selectedImage == null
        ? Card(
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                dashPattern: const [10, 5],
                strokeWidth: 2,
                radius: const Radius.circular(6),
                color: AppTheme.primaryColor,
              ),
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FAFE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_rounded,
                        size: 48,
                        color: AppTheme.primaryColor,
                      ),
                      24.heightBox,
                      Text(
                        'Drag and drop medical scans',
                        style: context.bodyLarge?.extraBold,
                      ),
                      8.heightBox,
                      Text(
                        'Supports DICOM, JPG, PNG up to 500MB per file',
                        style: context.bodyMedium?.copyWith(
                          color: context.theme.hintColor,
                        ),
                      ),
                      24.heightBox,
                      TextButton(
                        onPressed: onPickImage,
                        style: TextButton.styleFrom(
                          minimumSize: const Size(160, 48),
                        ),
                        child: const Text('Browse Files'),
                      ),
                    ],
                  ).paddingAll(32),
                ),
              ),
            ).paddingAll(32),
          )
        : DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Image.network(
                selectedImage!.path,
              ).paddingSymmetric(vertical: 42),
            ),
          );
  }
}
