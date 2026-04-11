import 'dart:typed_data';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:cancer_ai_detection/src/features/upload/widgets/upload_card.dart';
import 'package:flutter/material.dart';

class UploadScanSection extends StatelessWidget {
  const UploadScanSection({
    super.key,
    required this.imageBytes,
    required this.onPickImage,
    required this.onCancel,
  });

  final Uint8List? imageBytes;
  final VoidCallback onPickImage;
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
                  imageBytes: imageBytes,
                  onPickImage: onPickImage,
                  onCancel: onCancel,
                ),
              ],
            ),
          )
        : UploadCard(
            imageBytes: imageBytes,
            onPickImage: onPickImage,
            onCancel: onCancel,
          );
  }
}
