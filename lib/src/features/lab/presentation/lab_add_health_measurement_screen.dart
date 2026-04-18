import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/date_list_tile.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_patients_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class LabAddHealthMeasurementScreen extends ConsumerStatefulWidget {
  const LabAddHealthMeasurementScreen({
    super.key,
    required this.patientId,
  });

  final UuidValue patientId;

  @override
  ConsumerState<LabAddHealthMeasurementScreen> createState() =>
      _LabAddHealthMeasurementScreenState();
}

class _LabAddHealthMeasurementScreenState
    extends ConsumerState<LabAddHealthMeasurementScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  MeasurementName measurementName = MeasurementName.albumin;
  double value = 0.0;
  DateTime measuredAt = DateTime.now();
  String? notes;
  bool isSaving = false;

  Future<void> saveMeasurement() async {
    if (isSaving) {
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() => isSaving = true);
    try {
      await client.lab.addMeasurement(
        widget.patientId,
        measurementName,
        value,
        measuredAt,
        notes,
      );
      ref.invalidate(labPatientsProvider);
      if (!mounted) return;
      GoRouter.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save health measurement: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
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
              value: measurementName,
              items: MeasurementName.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name.capitalize),
                    ),
                  )
                  .toList(),
              onChanged: (selected) {
                if (selected != null) {
                  measurementName = selected;
                }
              },
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
              validator: (input) {
                final parsed = double.tryParse(input ?? '');
                if (parsed == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: (newValue) => value = double.tryParse(newValue) ?? 0.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes',
              ),
              onChanged: (newValue) => notes = newValue,
            ),
          ],
        ),
      ),
      onSave: saveMeasurement,
    );
  }
}
