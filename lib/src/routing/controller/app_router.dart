import 'package:cancer_ai_detection/src/features/authentication/signin_screen.dart';
import 'package:cancer_ai_detection/src/features/doctor/doctor_form_screen.dart';
import 'package:cancer_ai_detection/src/features/health_measurement/presentation/add_health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/health_measurement/presentation/health_measurement_screen.dart';
import 'package:cancer_ai_detection/src/features/home/home_screen.dart';
import 'package:cancer_ai_detection/src/features/home/root_home.dart';
import 'package:cancer_ai_detection/src/features/home/scan_list_screen.dart';
import 'package:cancer_ai_detection/src/features/allergies/presentation/add_allergy_screen.dart';
import 'package:cancer_ai_detection/src/features/medical_history/presentation/add_medical_history_screen.dart';
import 'package:cancer_ai_detection/src/features/medical_history/presentation/medical_history_screen.dart';
import 'package:cancer_ai_detection/src/features/medication/presentation/add_medication_screen.dart';
import 'package:cancer_ai_detection/src/features/allergies/presentation/allergies_screen.dart';
import 'package:cancer_ai_detection/src/features/medication/presentation/medications_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/settings_screen.dart';
import 'package:cancer_ai_detection/src/features/upload/upload_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/patient_form_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/select_role_screen.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
const String patientProfileRoute = '/patient-profile';
const String allergiesRoute = 'allergies';
const String addAllergyRoute = 'add-allergy';
const String medicationsRoute = 'medications';
const String addMedicationRoute = 'add-medication';
const String medicalHistoryRoute = 'medical-history';
const String addMedicalHistoryRoute = 'add-medical-history';
const String healthMeasurmentsRoute = 'health-measurments';
const String addHealthMeasurmentRoute = 'add-health-measurment';

@Riverpod()
GoRouter router(Ref ref) {
  final userRole = ref.watch(userRoleProvider);
  final hasSelectedRole = userRole != null;
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
                    name: AppRoute.scanList.name,
                    path: allScansRoute,
                    builder: (context, state) => const ScanListScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoute.upload.name,
                path: uploadRoute,
                builder: (context, state) => const UploadScreen(),
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
