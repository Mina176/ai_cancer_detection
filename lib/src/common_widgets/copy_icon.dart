import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyIcon extends StatelessWidget {
  const CopyIcon({super.key, required this.textToCopy});
  final String textToCopy;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy, size: 20),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: textToCopy));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard')),
        );
      },
    );
  }
}
