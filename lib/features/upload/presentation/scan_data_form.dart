import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:flutter/material.dart';

class ScanDataForm extends StatelessWidget {
  const ScanDataForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Scan Type',
          style: context.bodyMedium?.bold,
        ),
        8.heightBox,
        DropdownButtonFormField<String>(
          items: ['CT Scan', 'MRI', 'X-Ray']
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'Select scan type',
            hintStyle: context.bodyMedium?.copyWith(
              color: context.theme.hintColor,
            ),
          ),
        ),
        16.heightBox,
        Text(
          'Date of Scan',
          style: context.bodyMedium?.bold,
        ),
        8.heightBox,
        TextField(
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {},
            ),
            hintText: 'dd/mm/yyyy',
            hintStyle: context.bodyMedium?.copyWith(
              color: context.theme.hintColor,
            ),
          ),
        ),
        16.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Clinical Notes', style: context.bodyMedium?.bold),
            Text(
              'Optional',
              style: context.bodyMedium?.copyWith(
                color: context.theme.hintColor,
              ),
            ),
          ],
        ),
        8.heightBox,
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText:
                'Enter relevant symptoms, history, or specific areas of concern...',
            hintStyle: context.bodyMedium?.copyWith(
              color: context.theme.hintColor,
            ),
          ),
        ),
        24.heightBox,
      ],
    ).paddingSymmetric(
      horizontal: Sizes.kHorizontalPadding,
      vertical: Sizes.kVerticalPadding,
    );
  }
}
