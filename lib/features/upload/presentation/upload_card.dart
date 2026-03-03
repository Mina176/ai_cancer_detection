import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/theming/app_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadCard extends StatelessWidget {
  const UploadCard({
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
    return imageBytes == null
        ? Card(
            elevation: 0,
            color: Colors.transparent,
            child: DottedBorder(
              options: const RoundedRectDottedBorderOptions(
                dashPattern: [10, 5],
                strokeWidth: 2,
                radius: Radius.circular(16),
                color: AppTheme.primaryColor,
              ),
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FAFE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_rounded,
                        size: 48,
                        color: Colors.blue,
                      ),
                      24.heightBox,
                      Text(
                        'Drag and drop medical scans',
                        style: context.bodyLarge?.extraBold,
                      ),
                      8.heightBox,
                      Text(
                        'Supports DICOM, JPG, PNG up to 500MB',
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
            ),
          )
        : DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: Image.memory(
                      imageBytes!,
                      fit: BoxFit.contain,
                    ).paddingSymmetric(vertical: 24),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: onCancel,
                  ),
                ],
              ),
            ),
          );
  }
}
