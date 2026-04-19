import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/features/lab/controller/lab_patients_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class LabPatientsScreen extends ConsumerStatefulWidget {
  const LabPatientsScreen({super.key});

  @override
  ConsumerState<LabPatientsScreen> createState() => _LabPatientsScreenState();
}

class _LabPatientsScreenState extends ConsumerState<LabPatientsScreen> {
  static const int _pageSize = 10;
  int _currentPage = 0;
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final request = LabPatientsPageRequest(
      limit: _pageSize,
      offset: _currentPage * _pageSize,
    );
    final patientsAsyncValue = ref.watch(labPatientsPageProvider(request));
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Assigned Patients'),
              actions: [
                IconButton(
                  onPressed: () =>
                      ref.invalidate(labPatientsPageProvider(request)),
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ],
            ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: patientsAsyncValue.when(
              data: (patients) {
                final filteredPatients = patients.where((patient) {
                  if (_searchQuery.trim().isEmpty) return true;
                  final query = _searchQuery.trim().toLowerCase();
                  final name = (patient.fullName ?? '').toLowerCase();
                  final phone = (patient.phone ?? '').toLowerCase();
                  return name.contains(query) || phone.contains(query);
                }).toList();
                if (patients.isEmpty) {
                  return const Center(
                    child: Text('No assigned patients found.'),
                  );
                }
                final hasNextPage = patients.length == _pageSize;
                return Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search by patient name or phone',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                    ),
                    12.heightBox,
                    Expanded(
                      child: filteredPatients.isEmpty
                          ? const Center(
                              child: Text(
                                'No matching patients on this page.',
                              ),
                            )
                          : ListView.separated(
                              itemCount: filteredPatients.length,
                              separatorBuilder: (context, index) => 8.heightBox,
                              itemBuilder: (context, index) {
                                final patient = filteredPatients[index];
                                return _PatientActionsCard(patient: patient);
                              },
                            ),
                    ),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _currentPage == 0
                              ? null
                              : () => setState(() => _currentPage -= 1),
                          icon: const Icon(Icons.chevron_left_rounded),
                          label: const Text('Previous'),
                        ),
                        Text('Page ${_currentPage + 1}'),
                        OutlinedButton.icon(
                          onPressed: hasNextPage
                              ? () => setState(() => _currentPage += 1)
                              : null,
                          icon: const Icon(Icons.chevron_right_rounded),
                          label: const Text('Next'),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error loading patients: $error'),
                    8.heightBox,
                    FilledButton.icon(
                      onPressed: () {
                        ref.invalidate(labPatientsPageProvider(request));
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PatientActionsCard extends StatelessWidget {
  const _PatientActionsCard({required this.patient});

  final PatientProfileModel patient;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patient.fullName ?? 'Unknown Patient',
              style: context.titleMedium?.bold,
            ),
            10.heightBox,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.labAddScan.name,
                      pathParameters: {
                        'patientId': patient.id.toString(),
                      },
                    );
                  },
                  icon: const Icon(Icons.upload_file_rounded),
                  label: const Text('Upload Scan'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.labAddHealthMeasurement.name,
                      pathParameters: {
                        'patientId': patient.id.toString(),
                      },
                    );
                  },
                  icon: const Icon(Icons.monitor_heart_rounded),
                  label: const Text('Add Health Measurement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
