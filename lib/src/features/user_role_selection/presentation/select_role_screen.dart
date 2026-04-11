import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/storage/shared_prefs/shared_prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as ref;

class SelectRoleScreen extends ConsumerWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: UserOption(
                icon: Icons.local_hospital,
                text: 'Doctor',
                onTap: () {
                  ref
                      .read(sharedPreferencesProvider)
                      .setString('userRole', 'doctor');
                  context.goNamed(AppRoute.doctorForm.name);
                },
              ),
            ),
            Expanded(
              child: UserOption(
                icon: Icons.person,
                text: 'Patient',
                onTap: () {
                  ref
                      .read(sharedPreferencesProvider)
                      .setString('userRole', 'patient');
                  context.goNamed(AppRoute.patientForm.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserOption extends StatelessWidget {
  const UserOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
