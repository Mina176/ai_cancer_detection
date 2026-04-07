import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/common_widgets/date_list_tile.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/features/medical_history/controller/medical_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class AddMedicalHistoryScreen extends ConsumerStatefulWidget {
  const AddMedicalHistoryScreen({super.key});

  @override
  ConsumerState<AddMedicalHistoryScreen> createState() =>
      _AddMedicalHistoryScreenState();
}

class _AddMedicalHistoryScreenState
    extends ConsumerState<AddMedicalHistoryScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime date = DateTime.now();
  MedicalHistoryType type = MedicalHistoryType.condition;
  String title = 'e.g. Diabetes';
  String? description;
  MedicalHistorySeverity? severity;
  MedicalHistoryStatus status = MedicalHistoryStatus.active;
  String? notes;

  Future<void> saveMedicalHistory() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await client.medicalHistory.create(
        date: date,
        type: type,
        title: title,
        description: description,
        severity: severity,
        status: status,
        notes: notes,
      );
      if (!mounted) return;
      ref.invalidate(medicalHistoryProvider);
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save medical history: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StickyBottomFormLayout(
      title: 'Add Medical History',
      formContent: Form(
        key: formKey,
        child: Column(
          spacing: 12,
          children: [
            DateListTile(
              title: 'Date',
              selectedDate: date,
              onSelectDate: (date) => setState(() => this.date = date),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (value) => title = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) => description = value,
            ),
            DropdownButtonFormField<MedicalHistoryType>(
              items: MedicalHistoryType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name.capitalize),
                    ),
                  )
                  .toList(),
              onChanged: (value) => type = value!,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
            ),
            DropdownButtonFormField<MedicalHistorySeverity>(
              items: MedicalHistorySeverity.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name.capitalize),
                    ),
                  )
                  .toList(),
              onChanged: (value) => severity = value!,
              decoration: const InputDecoration(
                labelText: 'Severity',
              ),
            ),
            DropdownButtonFormField<MedicalHistoryStatus>(
              initialValue: status,
              items: MedicalHistoryStatus.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name.capitalize),
                    ),
                  )
                  .toList(),
              onChanged: (value) => status = value!,
              decoration: const InputDecoration(
                labelText: 'Status',
              ),
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
      onSave: saveMedicalHistory,
    );
  }
}
