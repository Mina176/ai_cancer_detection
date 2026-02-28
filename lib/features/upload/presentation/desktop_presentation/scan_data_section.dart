import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/upload/data/prediction.dart';
import 'package:flutter/material.dart';

class ScanDataSection extends StatelessWidget {
  const ScanDataSection({
    super.key,
    required this.result,
    required this.isLoading,
    required this.onProcessImage,
    required this.onCancel,
  });

  final Prediction? result;
  final bool isLoading;
  final VoidCallback onProcessImage;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: isLoading
                ? CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      16.heightBox,
                      Text(
                        'Scan Type',
                        style: context.bodyMedium?.bold,
                      ).paddingSymmetric(horizontal: 16),
                      8.heightBox,
                      DropdownButtonFormField(
                        items: ['CT Scan', 'MRI', 'X-Ray']
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Select scan type',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.theme.hintColor,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 16),
                      16.heightBox,
                      Text(
                        'Date of Scan',
                        style: context.bodyMedium?.bold,
                      ).paddingSymmetric(horizontal: 16),
                      8.heightBox,
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {},
                          ),
                          hintText: 'dd/mm/yyyy',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.theme.hintColor,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 16),
                      16.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Clinical Notes',
                            style: context.bodyMedium?.bold,
                          ),
                          Text(
                            'Optional',
                            style: context.bodyMedium?.copyWith(
                              color: context.theme.hintColor,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16),
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
                      ).paddingSymmetric(horizontal: 16),
                    ],
                  ).paddingSymmetric(vertical: Sizes.kVerticalPadding / 2),
          ),
        ),
        Divider(
          height: 32,
        ),
        ElevatedButton(
          onPressed: onProcessImage,
          child: isLoading ? Text('Analyzing...') : Text('Start Analysis'),
        ).paddingSymmetric(horizontal: 16),
        8.heightBox,
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text('Cancel Upload'),
        ).paddingSymmetric(horizontal: 16),
        8.heightBox,
      ],
    );
  }
}

class DataheaderSection extends StatelessWidget {
  const DataheaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person, size: 24),
            4.widthBox,
            Text(
              'Patient Data',
              style: Theme.of(context).textTheme.bodyLarge?.extraBold,
            ),
          ],
        ).paddingSymmetric(
          horizontal: 12,
        ),
        6.heightBox,
        Text(
          'Link these scans to a patient record.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: context.theme.hintColor),
        ).paddingSymmetric(
          horizontal: 16,
        ),
        Divider(height: 32),
      ],
    );
  }
}
