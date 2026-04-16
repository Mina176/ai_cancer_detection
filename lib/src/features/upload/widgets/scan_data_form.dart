import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:cancer_ai_detection/src/common_widgets/date_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class ScanDataForm extends StatelessWidget {
  const ScanDataForm({
    super.key,
    required this.scanType,
    required this.bodyPart,
    required this.onScanChanged,
    required this.onBodyPartChanged,
    required this.selectedDate,
    required this.onSelectDate,
  });
  final ValueChanged<ScanType?> onScanChanged;
  final ValueChanged<BodyPart?> onBodyPartChanged;
  final ScanType scanType;
  final BodyPart bodyPart;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.kHorizontalPadding,
        vertical: Sizes.kVerticalPadding,
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Scan Type',
            style: context.bodyMedium?.bold,
          ),
          DropdownButtonFormField<ScanType>(
            items: ScanType.values
                .map(
                  (type) =>
                      DropdownMenuItem(value: type, child: Text(type.name)),
                )
                .toList(),
            onChanged: onScanChanged,
            decoration: InputDecoration(
              hintText: ScanType.values.first.name,
              hintStyle: context.bodyMedium?.copyWith(
                color: context.theme.hintColor,
              ),
            ),
          ),
          Text(
            'Body Part',
            style: context.bodyMedium?.bold,
          ),
          DropdownButtonFormField<BodyPart>(
            items: BodyPart.values
                .map(
                  (type) =>
                      DropdownMenuItem(value: type, child: Text(type.name)),
                )
                .toList(),
            onChanged: onBodyPartChanged,
            decoration: InputDecoration(
              hintText: BodyPart.values.first.name,
              hintStyle: context.bodyMedium?.copyWith(
                color: context.theme.hintColor,
              ),
            ),
          ),
          DateListTile(
            title: 'Date of Scan',
            onSelectDate: onSelectDate,
            selectedDate: selectedDate,
          ),
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
        ],
      ),
    );
  }
}
