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

class PatientDetails extends ConsumerWidget {
  const PatientDetails({super.key, required this.patientId});

  final UuidValue patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientDetailsProvider(patientId));
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Patient Details'),
            ),
      body: patientAsync.when(
        data: (patient) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.kHorizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    Card(
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
                                    crossAxisAlignment: context.isLandscape
                                        ? .center
                                        : .end,
                                    direction: context.isLandscape
                                        ? .horizontal
                                        : .vertical,
                                    children: [
                                      Text(
                                        'Patient ID: ${patient.id}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      CopyIcon(
                                        textToCopy: patient.id.toString(),
                                      ),
                                    ],
                                  ),
                                  Flex(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    direction: context.isLandscape
                                        ? .horizontal
                                        : .vertical,
                                    spacing: 8,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () =>
                                            GoRouter.of(context).pushNamed(
                                              AppRoute.patientDiagnoses.name,
                                              pathParameters: {
                                                'patientId': patientId
                                                    .toString(),
                                              },
                                            ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(180, 40),
                                        ),
                                        child: const Text(
                                          'View Diagnoses',
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () =>
                                            GoRouter.of(context).pushNamed(
                                              AppRoute.patientScans.name,
                                              pathParameters: {
                                                'patientId': patientId
                                                    .toString(),
                                              },
                                            ),
                                        child: const Text('View Scans'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final analysisAsync = ref.watch(
                            generatePatientAnalysisProvider(patientId),
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
                              child: Text('Error generating analysis: $error'),
                            ),
                          );
                        },
                      ),
                    ),
                    DetailsCard(patient: patient),
                  ],
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
