import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/features/settings/controller/allergies_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class AddAllergyScreen extends ConsumerStatefulWidget {
  const AddAllergyScreen({super.key});

  @override
  ConsumerState<AddAllergyScreen> createState() => _AddAllergyScreenState();
}

class _AddAllergyScreenState extends ConsumerState<AddAllergyScreen> {
  String allergen = '';
  String reaction = '';
  AllergySeverity severity = AllergySeverity.mild;
  DateTime diagnosedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> saveAllergy() async {
    if (!formKey.currentState!.validate()) return;
    try {
      final profile = await client.patientProfileModelEdit.getOrCreate();
      await client.allergy.addAllergies([
        AllergyModel(
          patientProfileId: profile.id!,
          allergen: allergen,
          reaction: reaction,
          severity: severity,
          diagnosedDate: diagnosedDate,
        ),
      ]);
      if (!mounted) return;
      ref.invalidate(allergiesProvider);
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save allergy: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StickyBottomFormLayout(
      title: 'Add Allergy',
      formContent: Form(
        key: formKey,
        child: Column(
          spacing: 12,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Allergen',
              ),
              onChanged: (value) => allergen = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Reaction',
              ),
              onChanged: (value) => reaction = value,
            ),
            DropdownButtonFormField<AllergySeverity>(
              items: const [
                DropdownMenuItem(
                  value: AllergySeverity.mild,
                  child: Text('Mild'),
                ),
                DropdownMenuItem(
                  value: AllergySeverity.moderate,
                  child: Text('Moderate'),
                ),
                DropdownMenuItem(
                  value: AllergySeverity.severe,
                  child: Text('Severe'),
                ),
              ],
              onChanged: (value) => severity = value!,
              decoration: const InputDecoration(
                labelText: 'Severity',
              ),
            ),
          ],
        ),
      ),
      onSave: saveAllergy,
    );
  }
}
