import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/generic_list_screen.dart';
import 'package:cancer_ai_detection/src/common_widgets/swipe_to_delete_wrapper.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/controller/medical_history_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class MedicalHistoryScreen extends ConsumerWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalHistoryAsyncValue = ref.watch(medicalHistoryProvider);
    return GenericListScreen<MedicalHistoryModel>(
      title: 'Medical History',
      asyncData: medicalHistoryAsyncValue,
      onAddPressed: () => context.goNamed(AppRoute.addMedicalHistory.name),
      itemBuilder: (context, medicalHistory) {
        return SwipeToDeleteWrapper(
          itemKey: ValueKey(medicalHistory.id),
          child: Card(
            child: ListTile(
              title: Text(medicalHistory.title),
              subtitle: Text(
                medicalHistory.severity != null
                    ? medicalHistory.severity!.name
                    : medicalHistory.status.name,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    medicalHistory.type.name,
                  ),
                  8.heightBox,
                  Text(
                    DateFormat(' d/M/y').format(medicalHistory.date),
                  ),
                ],
              ),
            ),
          ),
          onConfirmDelete: () async {
            try {
              await client.medicalHistory.delete(medicalHistory.id!);
              ref.invalidate(medicalHistoryProvider);
              return true;
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return false;
            }
          },
        );
      },
    );
  }
}
