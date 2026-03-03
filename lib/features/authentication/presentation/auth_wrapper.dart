import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key, required this.child});
  final Widget child;
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void didChangeDependencies() {
    client.auth.authInfoListenable.addListener(handleAuthChange);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(handleAuthChange);
    super.dispose();
  }

  void handleAuthChange() {
    if (client.auth.isAuthenticated) {
      context.go(homeRoute);
    } else {
      context.go(authRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
