import 'package:cancer_ai_detection/src/features/authentication/signin_screen.dart';
import 'package:cancer_ai_detection/src/features/home/home_screen.dart';
import 'package:cancer_ai_detection/src/features/home/root_home.dart';
import 'package:cancer_ai_detection/src/features/home/scan_list_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/add_allergy_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/add_medication_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/allergies_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/medications_screen.dart';
import 'package:cancer_ai_detection/src/features/settings/presentation/settings_screen.dart';
import 'package:cancer_ai_detection/src/features/upload/upload_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/doctor_form_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/patient_form_screen.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/presentation/select_role_screen.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

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

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: client.auth.isAuthenticated ? selectRoleRoute : authRoute,
  routes: [
    GoRoute(
      path: authRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: selectRoleRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const SelectRoleScreen();
      },
    ),
    GoRoute(
      path: patientFormRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const PatientFormScreen();
      },
    ),
    GoRoute(
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
              path: homeRoute,
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
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
              path: uploadRoute,
              builder: (context, state) => const UploadScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: settingsRoute,
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: allergiesRoute,
                  builder: (context, state) => const AllergiesScreen(),
                  routes: [
                    GoRoute(
                      path: addAllergyRoute,
                      builder: (context, state) => const AddAllergyScreen(),
                    ),
                  ],
                ),
                GoRoute(
                  path: medicationsRoute,
                  builder: (BuildContext context, GoRouterState state) {
                    return const MedicationsScreen();
                  },
                  routes: [
                    GoRoute(
                      path: addMedicationRoute,
                      builder: (BuildContext context, GoRouterState state) {
                        return const AddMedicationScreen();
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
