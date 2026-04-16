import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/controller/patients_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class DoctorPatientsScreen extends ConsumerStatefulWidget {
  const DoctorPatientsScreen({super.key});

  @override
  ConsumerState<DoctorPatientsScreen> createState() =>
      _DoctorPatientsScreenState();
}

class _DoctorPatientsScreenState extends ConsumerState<DoctorPatientsScreen> {
  PatientProfileModel? searchedPatient;
  bool isSearching = false;
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
            child: Column(
              spacing: 16,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search Patients',
                    hintText: 'Enter Patient UUID...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) async {
                    final input = value.trim();
                    if (input.length != 36) {
                      setState(() {
                        searchedPatient = null;
                        isSearching = false;
                      });
                      return;
                    }
                    try {
                      setState(() => isSearching = true);
                      final patient = await client.patient.getPatient(
                        UuidValue.fromString(input),
                      );
                      setState(() {
                        searchedPatient = patient;
                        isSearching = false;
                      });
                    } catch (e) {
                      setState(() {
                        searchedPatient = null;
                        isSearching = false;
                      });
                    }
                  },
                ),
                if (isSearching)
                  const Center(
                    child: SizedBox(
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (searchedPatient != null)
                  Card(
                    child: ListTile(
                      title: Text(
                        searchedPatient!.fullName ?? 'Unknown Patient',
                      ),
                      subtitle: Text(
                        searchedPatient!.id.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                          AppRoute.patientDetails.name,
                          pathParameters: {
                            'patientId': searchedPatient!.id.toString(),
                          },
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: patientsAsyncValue.when(
                      data: (patients) {
                        return ListView.separated(
                          itemCount: patients.length,
                          separatorBuilder: (context, index) => 6.heightBox,
                          itemBuilder: (context, index) {
                            final patient = patients[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  patient.fullName ?? 'Unknown Patient',
                                ),
                                subtitle: Text(
                                  patient.id.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                    AppRoute.patientDetails.name,
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
                      loading: () => const Center(
                        child: SizedBox(
                          height: 40,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stackTrace) =>
                          Text('Error loading patients: $error'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
