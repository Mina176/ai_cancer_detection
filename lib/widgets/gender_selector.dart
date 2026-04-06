import 'package:flutter/material.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.onChanged,
    required this.selectedGender,
  });
  final Gender? selectedGender;
  final ValueChanged<Gender?> onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      decoration: InputDecoration(hintText: 'Gender'),
      items: [
        DropdownMenuItem(value: Gender.male, child: Text('Male')),
        DropdownMenuItem(
          value: Gender.female,
          child: Text('Female'),
        ),
      ],
      initialValue: selectedGender,
      onChanged: onChanged,
    );
  }
}
