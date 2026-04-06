import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/features/settings/controller/medication_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/utils/app_router.dart';
import 'package:cancer_ai_detection/src/common_widgets/generic_list_screen.dart';
import 'package:cancer_ai_detection/src/common_widgets/swipe_to_delete_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class MedicationsScreen extends ConsumerWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicationAsyncValue = ref.watch(medicationsProvider);
    return GenericListScreen<MedicationModel>(
      title: 'Medications',
      asyncData: medicationAsyncValue,
      onAddPressed: () =>
          context.go('$settingsRoute/$medicationsRoute/$addMedicationRoute'),
      itemBuilder: (context, medication) {
        return SwipeToDeleteWrapper(
          itemKey: ValueKey(medication.id),
          child: Card(
            child: ListTile(
              title: Text(medication.name),
              subtitle: Text(medication.dosage),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(medication.frequency),
                  8.heightBox,
                  Text(
                    DateFormat(' d/M/y').format(medication.startDate),
                  ),
                ],
              ),
            ),
          ),
          onConfirmDelete: () async {
            try {
              await client.medication.removeMedications([medication.id!]);
              ref.invalidate(medicationsProvider);
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
