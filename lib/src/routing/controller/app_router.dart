import 'package:cancer_ai_detection/src/features/authentication/signin_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/diagnoses/presentation/add_diagnosis_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/doctor_form_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/doctor_patients_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/patient_details.dart';
import 'package:cancer_ai_detection/src/features/doctor/diagnoses/presentation/patient_diagnoses_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/patient_scans_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/scan_ai_analysis_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/patients/presentation/scan_details_screen.dart';
import 'package:cancer_ai_detection/src/features/lab/presentation/lab_add_health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/lab/presentation/lab_add_scan_screen.dart';
import 'package:cancer_ai_detection/src/features/lab/presentation/lab_patients_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/presentation/add_health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/presentation/health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/home/home_screen.dart';
import 'package:cancer_ai_detection/src/features/home/root_home.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/presentation/add_allergy_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/presentation/add_medical_history_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/presentation/medical_history_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/presentation/add_medication_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/presentation/allergies_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/presentation/medications_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/select_doctor/selected_doctor_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/settings_screen.dart';
import 'package:cancer_ai_detection/src/features/patient/upload/upload_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/patient_form_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/select_role_screen.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
const String authRoute = '/';
const String homeRoute = '/home';
const String selectRoleRoute = '/select-role';
const String doctorFormRoute = '/doctor-form';
const String patientFormRoute = '/patient-form';
const String uploadRoute = '/upload';
const String settingsRoute = '/settings';
const String allScansRoute = '/scan-list';
const String doctorPatientsRoute = 'doctor-patients';
const String labPatientsRoute = 'lab-patients';
const String labAddScanRoute = 'add-scan/:patientId';
const String labAddHealthMeasurementRoute = 'add-health-measurement/:patientId';
const String patientDetailsRoute = 'patient-details/:patientId';
const String patientDiagnosesRoute = 'patient-diagnoses/:patientId';
const String patientScansRoute = 'patient-scans/:patientId';
const String scanRoute = 'scan';
const String scanAnalysisRoute = 'ai-analysis';
const String addDiagnosisRoute = 'add-diagnosis';
const String patientProfileRoute = '/patient-profile';
const String allergiesRoute = 'allergies';
const String addAllergyRoute = 'add-allergy';
const String medicationsRoute = 'medications';
const String addMedicationRoute = 'add-medication';
const String medicalHistoryRoute = 'medical-history';
const String addMedicalHistoryRoute = 'add-medical-history';
const String healthMeasurmentsRoute = 'health-measurments';
const String addHealthMeasurmentRoute = 'add-health-measurment';
const String chooseDoctorRoute = 'choose-doctor';

@Riverpod()
GoRouter router(Ref ref) {
  final userRole = ref.watch(userRoleProvider);
  final hasSelectedRole = userRole != null;
  final isDoctor = userRole == 'doctor';
  final isLabSpecialist = userRole == 'labSpecialist';
  final isMedicalStaff = isDoctor || isLabSpecialist;
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: authRoute,
    refreshListenable: client.authSessionManager.authInfoListenable,
    redirect: (context, state) {
      final isAuthed = client.auth.isAuthenticated;
      final path = state.matchedLocation;

      if (!isAuthed) {
        return path == authRoute ? null : authRoute;
      }
      if (!hasSelectedRole) {
        return path == selectRoleRoute ? null : selectRoleRoute;
      }
      if (path == authRoute || path == selectRoleRoute) {
        return homeRoute;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: authRoute,
        name: AppRoute.auth.name,
        builder: (BuildContext context, GoRouterState state) {
          return const AuthScreen();
        },
      ),
      GoRoute(
        path: selectRoleRoute,
        name: AppRoute.selectRole.name,
        builder: (BuildContext context, GoRouterState state) {
          return const SelectRoleScreen();
        },
      ),
      GoRoute(
        name: AppRoute.patientForm.name,
        path: patientFormRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const PatientFormScreen();
        },
      ),
      GoRoute(
        name: AppRoute.doctorForm.name,
        path: doctorFormRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const DoctorFormScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            RootHome(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoute.home.name,
                path: homeRoute,
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    name: AppRoute.chooseDoctor.name,
                    path: chooseDoctorRoute,
                    builder: (context, state) =>
                        const PatientSelectedDoctorsScreen(),
                  ),
                  GoRoute(
                    name: AppRoute.doctorPatients.name,
                    path: doctorPatientsRoute,
                    builder: (context, state) => const DoctorPatientsScreen(),
                    routes: [
                      GoRoute(
                        name: AppRoute.patientDetails.name,
                        path: patientDetailsRoute,
                        builder: (context, state) {
                          final patientIdString =
                              state.pathParameters['patientId'] ?? '';
                          final patientUuid = UuidValue.fromString(
                            patientIdString,
                          );
                          return PatientDetails(patientId: patientUuid);
                        },
                      ),
                      GoRoute(
                        name: AppRoute.patientDiagnoses.name,
                        path: patientDiagnosesRoute,
                        builder: (context, state) {
                          final patientIdString =
                              state.pathParameters['patientId'] ?? '';
                          final patientUuid = UuidValue.fromString(
                            patientIdString,
                          );
                          return PatientDiagnosesScreen(patientId: patientUuid);
                        },
                        routes: [
                          GoRoute(
                            name: AppRoute.addDiagnosis.name,
                            path: addDiagnosisRoute,
                            builder: (context, state) {
                              final patientIdString =
                                  state.pathParameters['patientId'] ?? '';
                              final patientUuid = UuidValue.fromString(
                                patientIdString,
                              );
                              return AddDiagnosisScreen(patientId: patientUuid);
                            },
                          ),
                        ],
                      ),
                      GoRoute(
                        name: AppRoute.patientScans.name,
                        path: patientScansRoute,
                        builder: (context, state) {
                          final patientIdString =
                              state.pathParameters['patientId'] ?? '';
                          final patientUuid = UuidValue.fromString(
                            patientIdString,
                          );
                          return PatientScansScreen(patientId: patientUuid);
                        },
                        routes: [
                          GoRoute(
                            name: AppRoute.scan.name,
                            path: scanRoute,
                            builder: (context, state) {
                              final scan = state.extra;
                              return ScanDetailsScreen(
                                scan: scan is MedicalScanModel ? scan : null,
                              );
                            },
                            routes: [
                              GoRoute(
                                name: AppRoute.scanAnalysis.name,
                                path: scanAnalysisRoute,
                                builder: (context, state) {
                                  final extra = state.extra;
                                  final Map<String, dynamic>? extraMap =
                                      extra is Map<String, dynamic>
                                      ? extra
                                      : null;
                                  final medicalScan = extra is MedicalScanModel
                                      ? extra
                                      : extraMap?['medicalScan']
                                            as MedicalScanModel?;
                                  return ScanAiAnalysisScreen(
                                    medicalScan: medicalScan,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    name: AppRoute.labPatients.name,
                    path: labPatientsRoute,
                    builder: (context, state) => const LabPatientsScreen(),
                    routes: [
                      GoRoute(
                        name: AppRoute.labAddScan.name,
                        path: labAddScanRoute,
                        builder: (context, state) {
                          final patientIdString =
                              state.pathParameters['patientId'] ?? '';
                          final patientUuid = UuidValue.fromString(
                            patientIdString,
                          );
                          return LabAddScanScreen(patientId: patientUuid);
                        },
                      ),
                      GoRoute(
                        name: AppRoute.labAddHealthMeasurement.name,
                        path: labAddHealthMeasurementRoute,
                        builder: (context, state) {
                          final patientIdString =
                              state.pathParameters['patientId'] ?? '';
                          final patientUuid = UuidValue.fromString(
                            patientIdString,
                          );
                          return LabAddHealthMeasurementScreen(
                            patientId: patientUuid,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: isMedicalStaff
                    ? isDoctor
                          ? '${AppRoute.doctorPatients.name}Tab'
                          : '${AppRoute.labPatients.name}Tab'
                    : AppRoute.upload.name,
                path: isMedicalStaff
                    ? isDoctor
                          ? '/$doctorPatientsRoute'
                          : '/$labPatientsRoute'
                    : uploadRoute,
                builder: (context, state) => isMedicalStaff
                    ? isDoctor
                          ? const DoctorPatientsScreen()
                          : const LabPatientsScreen()
                    : const UploadScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoute.settings.name,
                path: settingsRoute,
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    name: AppRoute.allergies.name,
                    path: allergiesRoute,
                    builder: (context, state) => const AllergiesScreen(),
                    routes: [
                      GoRoute(
                        name: AppRoute.addAllergy.name,
                        path: addAllergyRoute,
                        builder: (context, state) => const AddAllergyScreen(),
                      ),
                    ],
                  ),
                  GoRoute(
                    name: AppRoute.medications.name,
                    path: medicationsRoute,
                    builder: (BuildContext context, GoRouterState state) {
                      return const MedicationsScreen();
                    },
                    routes: [
                      GoRoute(
                        name: AppRoute.addMedication.name,
                        path: addMedicationRoute,
                        builder: (BuildContext context, GoRouterState state) {
                          return const AddMedicationScreen();
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    name: AppRoute.medicalHistory.name,
                    path: medicalHistoryRoute,
                    builder: (BuildContext context, GoRouterState state) {
                      return const MedicalHistoryScreen();
                    },
                    routes: [
                      GoRoute(
                        name: AppRoute.addMedicalHistory.name,
                        path: addMedicalHistoryRoute,
                        builder: (BuildContext context, GoRouterState state) {
                          return const AddMedicalHistoryScreen();
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    name: AppRoute.healthMeasurments.name,
                    path: healthMeasurmentsRoute,
                    builder: (BuildContext context, GoRouterState state) {
                      return const HealthMeasurementsScreen();
                    },
                    routes: [
                      GoRoute(
                        name: AppRoute.addHealthMeasurement.name,
                        path: addHealthMeasurmentRoute,
                        builder: (BuildContext context, GoRouterState state) {
                          return const AddHealthMeasurementScreen();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
