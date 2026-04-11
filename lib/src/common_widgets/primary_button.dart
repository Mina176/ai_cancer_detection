import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final Future<void> Function() onPressed;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isLoading = false;

  Future<void> handlePress() async {
    if (isLoading) return;
    setState(() => isLoading = true);
    try {
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Sizes.kVerticalPadding,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : handlePress,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )
            : Text(widget.label),
      ),
    );
  }
}
