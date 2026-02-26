import 'dart:io';

import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/theming/app_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadImageSection extends StatelessWidget {
  const UploadImageSection({
    super.key,
    required this.selectedImage,
    required this.isLoading,
    required this.onPickImage,
    required this.onProcessImage,
  });

  final File? selectedImage;
  final bool isLoading;
  final VoidCallback onPickImage;
  final VoidCallback onProcessImage;

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
    return Card(
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 5],
          strokeWidth: 2,
          radius: Radius.circular(6),
          color: AppTheme.primaryColor,
        ),
        child: selectedImage != null
            ? Image.file(selectedImage!, fit: BoxFit.contain)
            : Center(
                child: SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFF4FAFE),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
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
                          'supports DICOM, JPG, PNG up to 500MB per file',
                          style: context.bodyMedium?.copyWith(
                            color: context.theme.hintColor,
                          ),
                        ),
                        24.heightBox,
                        TextButton(
                          onPressed: onPickImage,
                          child: Text('Browse Files'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ).paddingAll(32),
    );
  }
}
