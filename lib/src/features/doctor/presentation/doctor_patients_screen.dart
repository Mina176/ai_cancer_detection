import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class DoctorPatientsScreen extends StatefulWidget {
  const DoctorPatientsScreen({super.key});

  @override
  State<DoctorPatientsScreen> createState() => _DoctorPatientsScreenState();
}

class _DoctorPatientsScreenState extends State<DoctorPatientsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _patientIdController = TextEditingController();
  final List<String> _recentPatientIds = [];

  @override
  void dispose() {
    _patientIdController.dispose();
    super.dispose();
  }

  String? _uuidValidator(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Patient profile ID is required.';
    }

    try {
      UuidValue.fromString(input);
    } on FormatException {
      return 'Enter a valid UUID value.';
    }

    return null;
  }

  Future<void> _pasteFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final clipboardText = clipboardData?.text?.trim() ?? '';
    if (clipboardText.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Clipboard is empty.')),
      );
      return;
    }

    setState(() {
      _patientIdController.text = clipboardText;
    });
  }

  void _addToRecentPatients(String patientId) {
    setState(() {
      _recentPatientIds.remove(patientId);
      _recentPatientIds.insert(0, patientId);
      if (_recentPatientIds.length > 5) {
        _recentPatientIds.removeLast();
      }
    });
  }

  void _openFromRecentPatient(String patientId, {required bool openAdd}) {
    _patientIdController.text = patientId;

    if (openAdd) {
      _openAddDiagnosis();
      return;
    }
    _openDiagnoses();
  }

  void _openDiagnoses() {
    if (!_formKey.currentState!.validate()) return;
    final patientId = _patientIdController.text.trim();
    _addToRecentPatients(patientId);

    GoRouter.of(context).pushNamed(
      AppRoute.patientDiagnoses.name,
      pathParameters: {'patientId': patientId},
    );
  }

  void _openAddDiagnosis() {
    if (!_formKey.currentState!.validate()) return;
    final patientId = _patientIdController.text.trim();
    _addToRecentPatients(patientId);

    GoRouter.of(context).pushNamed(
      AppRoute.addDiagnosis.name,
      pathParameters: {'patientId': patientId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Patients'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Patient By Profile ID',
                    style: context.headlineSmall,
                  ),
                  8.heightBox,
                  Text(
                    'Paste the patient profile UUID to view history or add a diagnosis.',
                    style: context.bodyMedium,
                  ),
                  16.heightBox,
                  TextFormField(
                    controller: _patientIdController,
                    validator: _uuidValidator,
                    decoration: InputDecoration(
                      labelText: 'Patient Profile ID',
                      hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                      suffixIcon: IconButton(
                        onPressed: _pasteFromClipboard,
                        icon: const Icon(Icons.content_paste_rounded),
                        tooltip: 'Paste from clipboard',
                      ),
                    ),
                  ),
                  16.heightBox,
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _openDiagnoses,
                        icon: const Icon(Icons.folder_shared_outlined),
                        label: const Text('View Diagnoses'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _openAddDiagnosis,
                        icon: const Icon(Icons.post_add_rounded),
                        label: const Text('Add Diagnosis'),
                      ),
                    ],
                  ),
                  if (_recentPatientIds.isNotEmpty) ...[
                    20.heightBox,
                    Text('Recent Patients', style: context.titleMedium),
                    8.heightBox,
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _recentPatientIds
                          .map(
                            (id) => ActionChip(
                              label: Text(id),
                              onPressed: () => _openFromRecentPatient(
                                id,
                                openAdd: false,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
