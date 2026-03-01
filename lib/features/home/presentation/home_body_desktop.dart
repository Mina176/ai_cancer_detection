import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class HomeBodyDesktop extends StatelessWidget {
  const HomeBodyDesktop({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Greeting(),
            UserCard(),
          ],
        ),
        Text(
          'Quick Scan',
          style: context.headlineSmall?.extraBold,
        ),
        Row(
          children: [
            ScanOptions(
              icon: Icons.medical_information,
            ),
            ScanOptions(
              icon: Icons.medical_information,
            ),
          ],
        ),
      ],
    );
  }
}

class ScanOptions extends StatelessWidget {
  const ScanOptions({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            DecoratedBox(
              decoration: ShapeDecoration(
                color: const Color(0xFFDBEAFE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(19.52),
                child: Icon(
                  icon,
                  color: const Color(0xff0EA5E9),
                ),
              ),
            ),

            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cancer Screen',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Thoracic X-Ray Analysis',
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Good Morning', style: context.headlineMedium?.extraBold),
        Text("Ready to start today's diagnostics?"),
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: const Color(0xFFF3F4F6),
        ),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),

        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text('JD'),
                ),
              ],
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              'Dr.Reynolds',
              style: context.bodyMedium?.bold,
            ),
          ],
        ),
      ),
    );
  }
}
