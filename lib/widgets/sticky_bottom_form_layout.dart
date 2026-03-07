import 'package:cancer_ai_detection/constants.dart';
import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class StickyBottomFormLayout extends StatelessWidget {
  final String title;
  final Widget formContent;
  final bool isLoading;
  final VoidCallback? onSave;

  const StickyBottomFormLayout({
    super.key,
    required this.title,
    required this.formContent,
    required this.isLoading,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape ? null : AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: formContent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: Sizes.kBottomButtonPadding,
              ),
              child: ElevatedButton(
                onPressed: isLoading ? null : onSave,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
