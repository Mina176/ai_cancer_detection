import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/features/doctor/patients/controller/scan_prediction_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class ScanAiAnalysisScreen extends ConsumerWidget {
  const ScanAiAnalysisScreen({
    super.key,
    required this.medicalScan,
  });

  final MedicalScanModel? medicalScan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final predictionAsync = ref.watch(scanPredictionProvider(medicalScan!.id!));
    if (medicalScan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('AI Analysis')),
        body: const Center(
          child: Text('Scan details are unavailable for this item.'),
        ),
      );
    }
    print(
      'Scan ID: ${medicalScan!.id}, Prediction Async State: $predictionAsync',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: medicalScan?.id == null
                ? null
                : () =>
                      ref.invalidate(scanPredictionProvider(medicalScan!.id!)),
            tooltip: 'Refresh Prediction',
          ),
        ],
      ),
      body: predictionAsync.when(
        data: (prediction) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.kVerticalPadding,
              horizontal: Sizes.kHorizontalPadding,
            ),
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: medicalScan!.imageUrl == null
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotoView(
                                  imageProvider: NetworkImage(
                                    medicalScan!.imageUrl!,
                                  ),
                                ),
                              ),
                            ),
                      child: Image.network(
                        medicalScan!.imageUrl ??
                            'https://via.placeholder.com/150?text=No+Image',
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Model Output',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Review the prediction before adding a doctor\'s diagnosis.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              16.heightBox,
              if (prediction == null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: const Text(
                      'No AI prediction found in the database for this scan yet. It may still be processing.',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnalysisTile(
                        label: 'Prediction Label',
                        value: _formatText(prediction?.predictionLabel),
                      ),
                      const Divider(height: 24),
                      AnalysisTile(
                        label: 'Probability',
                        value: _formatValue(prediction?.probability),
                      ),
                      const Divider(height: 24),
                      AnalysisTile(
                        label: 'Threshold',
                        value: _formatValue(prediction?.threshold),
                      ),
                      const Divider(height: 24),
                      AnalysisTile(
                        label: 'Scan Date',
                        value: DateFormat(
                          'd/M/y',
                        ).format(medicalScan!.scanDate),
                      ),
                    ],
                  ),
                ),
              ),
              16.heightBox,
              ElevatedButton.icon(
                onPressed: () => context.goNamed(
                  AppRoute.addDiagnosis.name,
                  pathParameters: {
                    'patientId': medicalScan!.patientProfileId.toString(),
                  },
                ),
                icon: const Icon(Icons.note_add_outlined),
                label: const Text('Add Doctor\'s Diagnosis'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Failed to load AI prediction: $error',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
    );
  }

  String _formatText(Object? value) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty) return 'Unavailable';
    return text;
  }

  String _formatValue(Object? value) {
    if (value == null) return 'Unavailable';

    if (value is num) {
      final double numericValue = value.toDouble();
      if (numericValue >= 0 && numericValue <= 1) {
        return '${(numericValue * 100).toStringAsFixed(1)}%';
      }
      return numericValue.toStringAsFixed(2);
    }
    return value.toString();
  }
}

class AnalysisTile extends StatelessWidget {
  const AnalysisTile({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
