import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => client.auth.signOutDevice(),
          child: Text('Log out'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Greeting(),
            UserCard(),
          ],
        ),
        Text(
          'Quick Scan',
          style: context.bodyMedium?.extraBold,
        ),
        Row(
          children: [
            ScanOptions(
              icon: Icons.medical_information,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Analyses',
              style: context.bodyMedium?.extraBold,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        FutureBuilder<List<MedicalScanModel>>(
          future: client.medicalScan.listMyScans(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final scans = snapshot.data ?? [];
            final lastThreeScans = scans.length <= 3
                ? scans
                : scans.sublist(scans.length - 3);
            if (scans.isEmpty) {
              return const Center(child: Text('No scans available'));
            }
            return ListView.builder(
              itemCount: lastThreeScans.length,
              itemBuilder: (context, index) {
                return ScanList(scan: lastThreeScans[index]);
              },
            );
          },
        ),
      ],
    );
  }
}

class ScanList extends StatelessWidget {
  const ScanList({
    super.key,
    required this.scan,
  });
  final MedicalScanModel scan;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(scan.id.toString()),
          Text(scan.uploadedAt.toString()),
          Text(scan.scanDate.toString()),
          Text(scan.scanType.name),
          Text(scan.bodyPart.toString()),
        ],
      ),
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
