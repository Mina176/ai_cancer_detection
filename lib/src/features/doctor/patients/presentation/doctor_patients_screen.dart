import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/features/doctor/patients/controller/patients_controller.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class DoctorPatientsScreen extends ConsumerWidget {
  const DoctorPatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsyncValue = ref.watch(filteredPatientsProvider);
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(title: const Text('Patients')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: Column(
              spacing: 16,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search Patients',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => ref
                      .read(patientSearchQueryProvider.notifier)
                      .setQuery(value.trim()),
                ),
                Expanded(child: buildBody(patientsAsyncValue)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(AsyncValue<List<PatientProfileModel>> patientsAsyncValue) {
    return patientsAsyncValue.when(
      data: (patients) => ListView.separated(
        itemCount: patients.length,
        separatorBuilder: (_, _) => 6.heightBox,
        itemBuilder: (_, index) => PatientListTile(patient: patients[index]),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text('Error loading patients: $error')),
    );
  }
}

class PatientListTile extends StatelessWidget {
  const PatientListTile({super.key, required this.patient});

  final PatientProfileModel patient;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(patient.fullName ?? 'Unknown Patient'),
        subtitle: Text(DateFormat.yMMMd().format(patient.dob!)),
        onTap: () => context.pushNamed(
          AppRoute.patientDetails.name,
          pathParameters: {'patientId': patient.id.toString()},
        ),
      ),
    );
  }
}
