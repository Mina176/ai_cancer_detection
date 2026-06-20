import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:cancer_ai_detection/src/common_widgets/copy_icon.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class ScanDetailsScreen extends StatelessWidget {
  const ScanDetailsScreen({super.key, required this.scan});
  final MedicalScanModel? scan;

  @override
  Widget build(BuildContext context) {
    if (scan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Scan Details')),
        body: const Center(
          child: Text('Scan details are unavailable for this item.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Details')),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.kVerticalPadding,
          horizontal: Sizes.kHorizontalPadding,
        ),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    title: GestureDetector(
                      onTap: scan!.imageUrl == null
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotoView(
                                  imageProvider: NetworkImage(scan!.imageUrl!),
                                ),
                              ),
                            ),
                      child: Image.network(
                        scan!.imageUrl ??
                            'https://via.placeholder.com/150?text=No+Image',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('scan ID'),
                    subtitle: Text(scan!.id.toString()),
                    trailing: CopyIcon(textToCopy: scan!.id.toString()),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Patient Profile ID'),
                    subtitle: Text(scan!.patientProfileId.toString()),
                    trailing: CopyIcon(
                      textToCopy: scan!.patientProfileId.toString(),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Body Part'),
                    subtitle: Text(scan!.bodyPart.name),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Scan Date'),
                    subtitle: Text(
                      DateFormat('d/M/y').format(scan!.scanDate),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Notes'),
                    subtitle: Text(
                      scan!.notes ?? 'No additional notes provided.',
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Uploaded At'),
                    subtitle: Text(
                      scan!.uploadedAt != null
                          ? DateFormat('d/M/y').format(scan!.uploadedAt!)
                          : 'Unknown Date',
                    ),
                  ),
                ],
              ),
            ),
          ),
          16.heightBox,
          FilledButton(
            onPressed: () => context.pushNamed(
              AppRoute.scanAnalysis.name,
              extra: scan,
            ),
            child: const Text('View AI Analysis'),
          ),
        ],
      ),
    );
  }
}
