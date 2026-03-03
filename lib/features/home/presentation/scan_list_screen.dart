import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/helpers.dart';
import 'package:flutter/material.dart';

class ScanListScreen extends StatelessWidget {
  const ScanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: Text('Scan History'),
            ),
      body: FutureBuilder(
        future: client.medicalScan.listMyScans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final scans = snapshot.data ?? [];
          if (scans.isEmpty) {
            return const Center(child: Text('No scans available'));
          }
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) {
              return ScanListWidget(
                scan: scans[index],
              );
            },
          );
        },
      ),
    );
  }
}
