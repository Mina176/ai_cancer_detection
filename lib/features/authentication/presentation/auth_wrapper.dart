import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: client.authSessionManager.authInfoListenable,
      builder: (context, authInfo, _) {
        if (authInfo != null) {
          Future.microtask(() => context.go(homeRoute));
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: Center(
            child: SignInWidget(
              client: client,
              onAuthenticated: () {},
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
