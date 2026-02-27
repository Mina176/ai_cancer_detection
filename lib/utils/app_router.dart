import 'package:cancer_ai_detection/features/authentication/presentation/auth_wrapper.dart';
import 'package:cancer_ai_detection/features/authentication/presentation/signin/signin_screen.dart';
import 'package:cancer_ai_detection/features/authentication/presentation/signup/signup_screen.dart';
import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:cancer_ai_detection/features/home/presentation/root_home.dart';
import 'package:cancer_ai_detection/features/upload_image/presentation/upload_screen_desktop.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
const String authWrapperRoute = '/';
const String homeRoute = '/home';
const String signinRoute = '/signin';
const String signupRoute = '/signup';
const String uploadRoute = '/upload';

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: authWrapperRoute,
  routes: [
    GoRoute(
      path: authWrapperRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper();
      },
    ),
    GoRoute(
      path: signinRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const SigninScreen();
      },
    ),
    GoRoute(
      path: signupRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const SignupScreen();
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
              path: '/settings',
              builder: (context, state) =>
                  const Center(child: Text('Settings Screen')),
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
