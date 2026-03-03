import 'package:cancer_ai_detection/features/authentication/presentation/signin_screen.dart';
import 'package:cancer_ai_detection/features/authentication/presentation/signup_screen.dart';
import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:cancer_ai_detection/features/home/presentation/root_home.dart';
import 'package:cancer_ai_detection/features/home/presentation/scan_list_screen.dart';
import 'package:cancer_ai_detection/features/upload/presentation/upload_screen.dart';
import 'package:cancer_ai_detection/features/user_role_selection/presentation/patient_form_screen.dart';
import 'package:cancer_ai_detection/features/user_role_selection/presentation/select_role_screen.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
const String authRoute = '/';
const String homeRoute = '/home';
const String selectRoleRoute = '/select-role';
const String patientFormRoute = '/patient-form';
const String uploadRoute = '/upload';
const String settingsRoute = '/settings';
const String allScansRoute = '/scan-list';
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
              path: '/help',
              builder: (context, state) =>
                  const Center(child: Text('Help Screen')),
            ),
          ],
        ),
      ],
    ),
  ],
);
