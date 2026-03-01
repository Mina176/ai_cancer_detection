import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:flutter/material.dart';

class StickyUploadButton extends StatelessWidget {
  const StickyUploadButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Upload to AI Model'),
    ).paddingSymmetric(
      horizontal: Sizes.kHorizontalPadding,
      vertical: Sizes.kVerticalPadding,
    );
  }
}
