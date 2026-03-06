import 'package:cancer_ai_detection/features/home/presentation/header.dart';
import 'package:cancer_ai_detection/features/home/presentation/scan_option.dart';
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
        padding: EdgeInsets.only(
          left: Sizes.kHorizontalPadding,
          right: Sizes.kHorizontalPadding,
          top: context.isLandscape ? Sizes.kVerticalPadding : 0,
          bottom: Sizes.kBottomButtonPadding,
        ),
        child: CustomScrollView(
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
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ScanOption(
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
                      final scan = lastThreeScans[index];
                      return Card(
                        child: ListTile(
                          title: Text(scan.scanType.name),
                          subtitle: Text(scan.bodyPart.name),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
