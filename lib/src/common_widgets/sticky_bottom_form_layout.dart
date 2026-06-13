import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class StickyBottomFormLayout extends StatelessWidget {
  final String title;
  final Widget formContent;
  final Future<void> Function() onSave;

  const StickyBottomFormLayout({
    super.key,
    required this.title,
    required this.formContent,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape ? null : AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: formContent,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
