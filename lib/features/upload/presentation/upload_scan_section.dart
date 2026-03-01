import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/upload/presentation/upload_card.dart';
import 'package:cancer_ai_detection/features/upload/presentation/upload_screen.dart';
import 'package:flutter/material.dart';

class UploadScanSection extends StatelessWidget {
  const UploadScanSection({
    super.key,
    required this.selectedImage,
    required this.onPickImage,
    required this.onCancel,
  });

  final File? selectedImage;
  final VoidCallback onPickImage;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return context.isLandscape
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Diagnostic Scan',
                style: context.displaySmall?.extraBold,
              ),
              4.heightBox,
              Text(
                'Upload patient imaging files for AI-assisted diagnostic analysis.',
                style: context.bodyLarge?.copyWith(
                  color: context.theme.hintColor,
                ),
              ),
              32.heightBox,
              UploadCard(
                selectedImage: selectedImage,
                onPickImage: onPickImage,
                onCancel: onCancel,
              ),
            ],
          ).paddingSymmetric(
            horizontal: Sizes.kHorizontalPadding,
            vertical: Sizes.kVerticalPadding,
          )
        : UploadCard(
            selectedImage: selectedImage,
            onPickImage: onPickImage,
            onCancel: onCancel,
          ).paddingSymmetric(
            horizontal: Sizes.kHorizontalPadding,
            vertical: Sizes.kVerticalPadding,
          );
  }
}
