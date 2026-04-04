import 'package:cancer_ai_detection/features/settings/data/allergies_provider.dart';
import 'package:cancer_ai_detection/features/settings/data/medication_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/widgets/date_list_tile.dart';
import 'package:cancer_ai_detection/widgets/sticky_bottom_form_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class AddMedicationScreen extends ConsumerStatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  ConsumerState<AddMedicationScreen> createState() =>
      _AddMedicationScreenState();
}

class _AddMedicationScreenState extends ConsumerState<AddMedicationScreen> {
  String name = '';
  String dosage = '';
  String frequency = '';
  DateTime startDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> saveMedication() async {
    if (!formKey.currentState!.validate()) return;
    try {
      final profile = await client.patientProfileModelEdit.getOrCreate();
      await client.medication.addMedications([
        MedicationModel(
          patientProfileId: profile.id!,
          name: name,
          dosage: dosage,
          frequency: frequency,
          startDate: startDate,
        ),
      ]);
      ref.invalidate(medicationsProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save medication')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StickyBottomFormLayout(
      title: 'Add Medication',
      formContent: Form(
        key: formKey,
        child: Column(
          spacing: 12,
          children: [
            DateListTile(
              title: 'Start Date',
              onSelectDate: (value) => setState(() {
                startDate = value;
              }),
              selectedDate: startDate,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Medication Name',
              ),
              onChanged: (value) => name = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Dosage',
              ),
              onChanged: (value) => dosage = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Frequency',
              ),
              onChanged: (value) => frequency = value,
            ),
          ],
        ),
      ),
      onSave: saveMedication,
    );
  }
}
