import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SelectRoleScreen extends ConsumerWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          spacing: 16,
          children: [
            Text(
              'Hello, Select Your Role',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            UserOption(
              icon: Icon(Icons.person_rounded, size: 36),
              text: 'Patient',
              onTap: () {
                ref.read(userRoleProvider.notifier).setRole('patient');
                context.goNamed(AppRoute.home.name);
              },
            ),
            UserOption(
              icon: Icon(Icons.local_hospital_rounded, size: 32),
              text: 'Doctor',
              onTap: () {
                ref.read(userRoleProvider.notifier).setRole('doctor');
                context.goNamed(AppRoute.home.name);
              },
            ),
            UserOption(
              icon: Icon(Icons.biotech_rounded, size: 36),
              text: 'Lab Specialist',
              onTap: () {
                ref.read(userRoleProvider.notifier).setRole('labSpecialist');
                context.goNamed(AppRoute.home.name);
              },
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
  final Icon icon;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              icon,
              Text(text, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
