import 'package:cancer_ai_detection/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: UserOption(
                icon: Icons.local_hospital,
                text: 'Doctor',
                onTap: () {
                  context.go(doctorFormRoute);
                },
              ),
            ),
            Expanded(
              child: UserOption(
                icon: Icons.person,
                text: 'Patient',
                onTap: () {
                  context.go(patientFormRoute);
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
