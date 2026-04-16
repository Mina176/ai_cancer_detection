import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/common_widgets/date_list_tile.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/controller/health_measurement_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class AddHealthMeasurementScreen extends ConsumerStatefulWidget {
  const AddHealthMeasurementScreen({super.key});

  @override
  ConsumerState<AddHealthMeasurementScreen> createState() =>
      _AddMeasurementScreenState();
}

class _AddMeasurementScreenState
    extends ConsumerState<AddHealthMeasurementScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  MeasurementName measurementName = MeasurementName.albumin;
  double value = 0.0;
  DateTime measuredAt = DateTime.now();
  String? notes;

  Future<void> saveHealthMeasurement() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await client.healthMeasurement.create(
        name: measurementName,
        value: value,
        measuredAt: measuredAt,
        notes: notes,
      );
      if (!mounted) return;
      ref.invalidate(healthMeasurementProvider);
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save health measurement: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StickyBottomFormLayout(
      title: 'Add Health Measurement',
      formContent: Form(
        key: formKey,
        child: Column(
          spacing: 12,
          children: [
            DateListTile(
              title: 'Measured At',
              selectedDate: measuredAt,
              onSelectDate: (date) => setState(() => measuredAt = date),
            ),
            DropdownButtonFormField<MeasurementName>(
              items: MeasurementName.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name.capitalize),
                    ),
                  )
                  .toList(),
              onChanged: (value) => measurementName = value!,
              decoration: const InputDecoration(
                labelText: 'Measurement Name',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Value',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (newValue) => value = double.tryParse(newValue) ?? 0.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes',
              ),
              onChanged: (value) => notes = value,
            ),
          ],
        ),
      ),
      onSave: saveHealthMeasurement,
    );
  }
}
