import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/common_widgets/copy_icon.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/controller/patient_details_provider.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/details_card.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:async';

class PatientDetails extends ConsumerStatefulWidget {
  const PatientDetails({super.key, required this.patientId});

  final UuidValue patientId;

  @override
  ConsumerState<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends ConsumerState<PatientDetails> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (!mounted) return;
      ref.invalidate(patientDetailsProvider(widget.patientId));
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshPatientDetails() async {
    ref.invalidate(patientDetailsProvider(widget.patientId));
    final _ = await ref.refresh(
      patientDetailsProvider(widget.patientId).future,
    );
  }

  @override
  Widget build(BuildContext context) {
    final patientAsync = ref.watch(patientDetailsProvider(widget.patientId));
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Patient Details'),
              actions: [
                IconButton(
                  tooltip: 'Refresh patient data',
                  onPressed: _refreshPatientDetails,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
      body: patientAsync.when(
        data: (patient) {
          final scans = [
            MedicalScanModel(
              patientProfileId: UuidValue.fromString(
                '019d9dbd-08de-7caf-9481-6ca2edf343e8',
              ),
              scanType: ScanType.ct,
              bodyPart: BodyPart.chest,
              scanDate: DateTime.now(),
            ),
          ];
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: RefreshIndicator(
                onRefresh: _refreshPatientDetails,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.kHorizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8,
                    children: [
                      ContactCard(
                        patient: patient,
                        patientId: widget.patientId,
                      ),
                      DetailsCard(patient: patient),
                      GenericDetailsCard(
                        patient: patient,
                        title: 'Diagnoses',
                        child: patient.diagnoses!.isEmpty
                            ? const Text('No diagnoses found.')
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (
                                    int i = 0;
                                    i < patient.diagnoses!.length;
                                    i++
                                  ) ...[
                                    LabeledText(
                                      icon: Icons.biotech_outlined,
                                      label: 'Diagnosis',
                                      value:
                                          patient.diagnoses![i].diagnosisText,
                                    ),
                                    if ((patient.diagnoses![i].icd10Code ?? '')
                                        .isNotEmpty)
                                      LabeledText(
                                        icon: Icons.qr_code_2_outlined,
                                        label: 'ICD-10',
                                        value: patient.diagnoses![i].icd10Code!,
                                      ),
                                    LabeledText(
                                      icon: Icons.warning_amber_rounded,
                                      label: 'Severity',
                                      value:
                                          patient.diagnoses![i].severity.name,
                                    ),
                                    if (patient.diagnoses![i].createdAt != null)
                                      LabeledText(
                                        icon: Icons.event_outlined,
                                        label: 'Created At',
                                        value: DateFormat('d/M/y').format(
                                          patient.diagnoses![i].createdAt!,
                                        ),
                                      ),
                                    if ((patient.diagnoses![i].notes ?? '')
                                        .isNotEmpty)
                                      LabeledText(
                                        icon: Icons.notes_outlined,
                                        label: 'Notes',
                                        value: patient.diagnoses![i].notes!,
                                      ),
                                    if (patient.diagnoses![i].id != null)
                                      LabeledText(
                                        icon: Icons.tag_outlined,
                                        label: 'ID',
                                        value: patient.diagnoses![i].id
                                            .toString(),
                                      ),
                                    if (i != patient.diagnoses!.length - 1)
                                      const Divider(height: 20),
                                  ],
                                ],
                              ),
                        onViewAllPressed: () => GoRouter.of(context).pushNamed(
                          AppRoute.patientDiagnoses.name,
                          pathParameters: {
                            'patientId': widget.patientId.toString(),
                          },
                        ),
                      ),
                      GenericDetailsCard(
                        patient: patient,
                        title: 'Medical Scans',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < scans.length; i++) ...[
                              if ((scans[i].imageUrl ?? '').isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PhotoView(
                                            imageProvider: NetworkImage(
                                              scans[i].imageUrl!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Image.network(
                                        scans[i].imageUrl!,
                                        height: 140,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              LabeledText(
                                icon: Icons.document_scanner_rounded,
                                label: 'Scan Type',
                                value: scans[i].scanType.name,
                              ),
                              LabeledText(
                                icon: Icons.accessibility_new_outlined,
                                label: 'Body Part',
                                value: scans[i].bodyPart.name,
                              ),
                              LabeledText(
                                icon: Icons.event_outlined,
                                label: 'Scan Date',
                                value: DateFormat('d/M/y').format(
                                  scans[i].scanDate,
                                ),
                              ),
                              if ((scans[i].notes ?? '').isNotEmpty)
                                LabeledText(
                                  icon: Icons.sticky_note_2_outlined,
                                  label: 'Notes',
                                  value: scans[i].notes!,
                                ),
                              if (scans[i].uploadedAt != null)
                                LabeledText(
                                  icon: Icons.cloud_upload_outlined,
                                  label: 'Uploaded At',
                                  value: DateFormat('d/M/y').format(
                                    scans[i].uploadedAt!,
                                  ),
                                ),
                              if (scans[i].prediction == null)
                                LabeledText(
                                  icon: Icons.psychology_outlined,
                                  label: 'AI Prediction',
                                  value: 'No AI prediction yet',
                                )
                              else ...[
                                LabeledText(
                                  icon: Icons.psychology_outlined,
                                  label: 'Prediction',
                                  value: scans[i].prediction!.predictionLabel,
                                ),
                                if ((scans[i].prediction!.rawOutput ?? '')
                                    .isNotEmpty)
                                  LabeledText(
                                    icon: Icons.description_outlined,
                                    label: 'LLM Output',
                                    value: scans[i].prediction!.rawOutput!,
                                  ),
                                LabeledText(
                                  icon: Icons.percent_outlined,
                                  label: 'Probability',
                                  value:
                                      '${(scans[i].prediction!.probability * 100).toStringAsFixed(1)}%',
                                ),
                                LabeledText(
                                  icon: Icons.tune_outlined,
                                  label: 'Threshold',
                                  value:
                                      '${(scans[i].prediction!.threshold * 100).toStringAsFixed(1)}%',
                                ),
                              ],
                              if (i != scans.length - 1)
                                const Divider(height: 20),
                            ],
                          ],
                        ),
                        onViewAllPressed: () => GoRouter.of(context).pushNamed(
                          AppRoute.patientScans.name,
                          pathParameters: {
                            'patientId': widget.patientId.toString(),
                          },
                        ),
                      ),
                      GenericDetailsCard(
                        patient: patient,
                        title: 'Medications',
                        child: patient.medications!.isEmpty
                            ? const Text('No medications found.')
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (
                                    int i = 0;
                                    i < patient.medications!.length;
                                    i++
                                  ) ...[
                                    LabeledText(
                                      icon: Icons.medication_outlined,
                                      label: 'Name',
                                      value: patient.medications![i].name,
                                    ),
                                    LabeledText(
                                      icon: Icons.straighten_outlined,
                                      label: 'Dosage',
                                      value: patient.medications![i].dosage,
                                    ),
                                    LabeledText(
                                      icon: Icons.repeat_outlined,
                                      label: 'Frequency',
                                      value: patient.medications![i].frequency,
                                    ),
                                    LabeledText(
                                      icon: Icons.event_outlined,
                                      label: 'Start Date',
                                      value: DateFormat('d/M/y').format(
                                        patient.medications![i].startDate,
                                      ),
                                    ),
                                    if (i != patient.medications!.length - 1)
                                      const Divider(height: 20),
                                  ],
                                ],
                              ),
                      ),
                      GenericDetailsCard(
                        patient: patient,
                        title: 'Allergies',
                        child: patient.allergies!.isEmpty
                            ? const Text('No allergies found.')
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (
                                    int i = 0;
                                    i < patient.allergies!.length;
                                    i++
                                  ) ...[
                                    LabeledText(
                                      icon: Icons.coronavirus_outlined,
                                      label: 'Allergen',
                                      value: patient.allergies![i].allergen,
                                    ),
                                    LabeledText(
                                      icon: Icons.sick_outlined,
                                      label: 'Reaction',
                                      value: patient.allergies![i].reaction,
                                    ),
                                    LabeledText(
                                      icon: Icons.warning_amber_rounded,
                                      label: 'Severity',
                                      value:
                                          patient.allergies![i].severity.name,
                                    ),
                                    LabeledText(
                                      icon: Icons.event_outlined,
                                      label: 'Diagnosed Date',
                                      value: DateFormat('d/M/y').format(
                                        patient.allergies![i].diagnosedDate,
                                      ),
                                    ),
                                    if (i != patient.allergies!.length - 1)
                                      const Divider(height: 20),
                                  ],
                                ],
                              ),
                      ),
                      GenericDetailsCard(
                        patient: patient,
                        title: 'Health Measurements',
                        child:
                            patient.healthMeasurements == null ||
                                patient.healthMeasurements!.isEmpty
                            ? const Text('No health measurements found.')
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (
                                    int i = 0;
                                    i < patient.healthMeasurements!.length;
                                    i++
                                  ) ...[
                                    LabeledText(
                                      icon: Icons.monitor_heart_outlined,
                                      label: 'Name',
                                      value: patient
                                          .healthMeasurements![i]
                                          .name
                                          .name,
                                    ),
                                    LabeledText(
                                      icon: Icons.numbers_outlined,
                                      label: 'Value',
                                      value: patient
                                          .healthMeasurements![i]
                                          .value
                                          .toString(),
                                    ),
                                    LabeledText(
                                      icon: Icons.event_outlined,
                                      label: 'Measured At',
                                      value: DateFormat('d/M/y').format(
                                        patient
                                            .healthMeasurements![i]
                                            .measuredAt,
                                      ),
                                    ),
                                    if (i !=
                                        patient.healthMeasurements!.length - 1)
                                      const Divider(height: 20),
                                  ],
                                ],
                              ),
                      ),
                      GenericDetailsCard(
                        patient: patient,
                        title: 'Medical History',
                        child:
                            patient.medicalHistory == null ||
                                patient.medicalHistory!.isEmpty
                            ? const Text('No medical history found.')
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (
                                    int i = 0;
                                    i < patient.medicalHistory!.length;
                                    i++
                                  ) ...[
                                    LabeledText(
                                      icon: Icons.history_edu_outlined,
                                      label: 'Title',
                                      value: patient.medicalHistory![i].title,
                                    ),
                                    LabeledText(
                                      icon: Icons.category_outlined,
                                      label: 'Type',
                                      value:
                                          patient.medicalHistory![i].type.name,
                                    ),
                                    LabeledText(
                                      icon: Icons.rule_folder_outlined,
                                      label: 'Severity / Status',
                                      value:
                                          patient.medicalHistory![i].severity !=
                                              null
                                          ? patient
                                                .medicalHistory![i]
                                                .severity!
                                                .name
                                          : patient
                                                .medicalHistory![i]
                                                .status
                                                .name,
                                    ),
                                    LabeledText(
                                      icon: Icons.event_outlined,
                                      label: 'Date',
                                      value: DateFormat('d/M/y').format(
                                        patient.medicalHistory![i].date,
                                      ),
                                    ),
                                    if (i != patient.medicalHistory!.length - 1)
                                      const Divider(height: 20),
                                  ],
                                ],
                              ),
                      ),
                      Card(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final analysisAsync = ref.watch(
                              generatePatientAnalysisProvider(widget.patientId),
                            );
                            return analysisAsync.when(
                              data: (analysis) => Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(
                                      'AI Analysis',
                                      style: context.titleMedium?.extraBold,
                                    ),
                                    12.heightBox,
                                    MarkdownBody(data: analysis),
                                  ],
                                ),
                              ),
                              loading: () => const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Generating AI analysis...',
                                  textAlign: .center,
                                ),
                              ),
                              error: (error, stackTrace) => Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Error generating analysis: $error',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class GenericDetailsCard extends StatelessWidget {
  const GenericDetailsCard({
    super.key,
    required this.patient,
    required this.title,
    required this.child,
    this.onViewAllPressed,
  });
  final PatientProfileModel patient;
  final String title;
  final Widget child;
  final VoidCallback? onViewAllPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              title,
              style: context.titleMedium?.extraBold,
            ),
            12.heightBox,
            child,
            if (onViewAllPressed != null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onViewAllPressed,
                  child: const Text('View All'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LabeledText extends StatelessWidget {
  const LabeledText({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? Icons.circle_outlined, size: 16),
          8.widthBox,
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$label: ',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.patient,
    required this.patientId,
  });
  final PatientProfileModel patient;
  final UuidValue patientId;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: patient.imageUrl != null
                  ? NetworkImage(patient.imageUrl!)
                  : null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  Text(
                    patient.fullName ?? 'Unknown Patient',
                    style: context.headlineSmall?.extraBold,
                  ),
                  Flex(
                    crossAxisAlignment: context.isLandscape ? .center : .end,
                    direction: context.isLandscape ? .horizontal : .vertical,
                    children: [
                      Text(
                        'ID: ${patient.id}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      CopyIcon(
                        textToCopy: patient.id.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
