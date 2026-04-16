import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/generic_list_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/controller/patients_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class DoctorPatientsScreen extends ConsumerStatefulWidget {
  const DoctorPatientsScreen({super.key});

  @override
  ConsumerState<DoctorPatientsScreen> createState() =>
      _DoctorPatientsScreenState();
}

class _DoctorPatientsScreenState extends ConsumerState<DoctorPatientsScreen> {
  @override
  void initState() {
    super.initState();
    initProfile();
  }

  void initProfile() async {
    await client.doctorProfile.getOrCreate();
  }

  @override
  Widget build(BuildContext context) {
    final patientsAsyncValue = ref.watch(patientsProvider);
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
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: patientsAsyncValue.when(
              data: (patients) {
                return ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    final patient = patients[index];
                    return Card(
                      child: ListTile(
                        title: Text(patient.fullName ?? 'Unknown Patient'),
                        subtitle: Text('ID: ${patient.id}'),
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            AppRoute.patientDiagnoses.name,
                            pathParameters: {
                              'patientId': patient.id.toString(),
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) =>
                  Text('Error loading patients: $error'),
            ),
          ),
        ),
      ),
    );
  }
}
