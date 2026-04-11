import 'package:cancer_ai_detection/src/common_widgets/primary_button.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';

class StickyButtonWithScrollBody extends StatelessWidget {
  const StickyButtonWithScrollBody({
    super.key,
    required this.children,
    required this.onButtonPressed,
    required this.buttonLabel,
  });
  final List<Widget> children;
  final Future<void> Function() onButtonPressed;
  final String buttonLabel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.kHorizontalPadding,
          ),
          child: PrimaryButton(
            onPressed: onButtonPressed,
            label: buttonLabel,
          ),
        ),
      ],
    );
  }
}
