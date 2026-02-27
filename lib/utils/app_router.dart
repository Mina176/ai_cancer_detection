import 'package:cancer_ai_detection/features/authentication/presentation/signin/signin_screen.dart';
import 'package:cancer_ai_detection/features/authentication/presentation/signup/signup_screen.dart';
import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String homeRoute = '/';
const String signinRoute = '/signin';
const String signupRoute = '/signup';
final GoRouter router = GoRouter(
  initialLocation: signinRoute,
  routes: [
    GoRoute(
      path: homeRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
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
  ],
);
