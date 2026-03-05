import 'package:cancer_ai_detection/constants.dart';
import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              forceMaterialTransparency: true,
              title: const Text('Home Screen'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: Sizes.kHorizontalPadding,
          right: Sizes.kHorizontalPadding,
          bottom: Sizes.kBottomButtonPadding,
        ),
        child: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              8.heightBox,
              Text(
                'Quick Scan',
                style: context.bodyMedium?.extraBold,
              ),
              8.heightBox,
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ScanOptions(
                  icon: Icons.medical_information,
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
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
          ),
        ),
        SliverToBoxAdapter(
          child: FutureBuilder<List<MedicalScanModel>>(
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
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lastThreeScans.length,
                itemBuilder: (context, index) {
                  return ScanListWidget(scan: lastThreeScans[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Greeting(),
        UserCard(),
      ],
    );
  }
}

class ScanListWidget extends StatelessWidget {
  const ScanListWidget({
    super.key,
    required this.scan,
  });
  final MedicalScanModel scan;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(scan.scanType.name),
        subtitle: Text(scan.bodyPart.name),
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
    return SizedBox(
      height: 120,
      child: Card(
        margin: const EdgeInsets.only(right: 16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cancer Screen',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Thoracic X-Ray Analysis',
                  ),
                ],
              ),
            ],
          ),
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
        child: context.isLandscape
            ? Row(
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
              )
            : Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text('JD'),
                  ),
                ],
              ),
      ),
    );
  }
}
