import 'package:awesome_extensions/awesome_extensions_dart.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/features/doctor/diagnoses/controller/patient_diagnoses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class AddDiagnosisScreen extends ConsumerStatefulWidget {
  const AddDiagnosisScreen({
    super.key,
    required this.patientId,
  });

  final String patientId;

  @override
  ConsumerState<AddDiagnosisScreen> createState() => _AddDiagnosisScreenState();
}

class _AddDiagnosisScreenState extends ConsumerState<AddDiagnosisScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _diagnosisText = '';
  DiagnosisSeverity _severity = DiagnosisSeverity.mild;
  String? _icd10Code;
  String? _notes;
  bool _isAiAssisted = false;

  Future<void> _saveDiagnosis() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      final patientUuid = UuidValue.fromString(widget.patientId);
      await client.diagnosis.create(
        patientId: patientUuid,
        diagnosisText: _diagnosisText,
        severity: _severity,
        icd10Code: (_icd10Code ?? '').trim().isEmpty
            ? null
            : _icd10Code!.trim(),
        notes: (_notes ?? '').trim().isEmpty ? null : _notes!.trim(),
        isAiAssisted: _isAiAssisted,
      );

      ref.invalidate(patientDiagnosesProvider(widget.patientId));
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save diagnosis: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StickyBottomFormLayout(
      title: 'Add Diagnosis',
      onSave: _saveDiagnosis,
      formContent: Form(
        key: _formKey,
        child: Column(
          spacing: 12,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Diagnosis'),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Diagnosis is required'
                  : null,
              onSaved: (value) => _diagnosisText = value!.trim(),
            ),
            DropdownButtonFormField<DiagnosisSeverity>(
              initialValue: _severity,
              decoration: const InputDecoration(labelText: 'Severity'),
              items: DiagnosisSeverity.values
                  .map(
                    (severity) => DropdownMenuItem(
                      value: severity,
                      child: Text(severity.name.capitalizeFirst),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() {
                _severity = value ?? DiagnosisSeverity.mild;
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ICD-10 Code (Optional)',
              ),
              onSaved: (value) => _icd10Code = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes (Optional)',
              ),
              minLines: 3,
              maxLines: 5,
              onSaved: (value) => _notes = value,
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('AI Assisted'),
              value: _isAiAssisted,
              onChanged: (value) => setState(() {
                _isAiAssisted = value;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
