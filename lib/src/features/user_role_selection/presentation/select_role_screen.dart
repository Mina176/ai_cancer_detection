import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                  ref.read(userRoleProvider.notifier).setRole('doctor');
                  context.goNamed(AppRoute.doctorForm.name);
                },
              ),
            ),
            Expanded(
              child: UserOption(
                icon: Icons.person,
                text: 'Patient',
                onTap: () {
                  ref.read(userRoleProvider.notifier).setRole('patient');
                  context.goNamed(AppRoute.patientForm.name);
                },
              ),
            ),
            Expanded(
              child: UserOption(
                icon: Icons.biotech_rounded,
                text: 'Lab Specialist',
                onTap: () {
                  ref.read(userRoleProvider.notifier).setRole('labSpecialist');
                  context.goNamed(AppRoute.home.name);
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
