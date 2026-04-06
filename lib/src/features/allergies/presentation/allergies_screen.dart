import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/features/allergies/controllers/allergies_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/generic_list_screen.dart';
import 'package:cancer_ai_detection/src/common_widgets/swipe_to_delete_wrapper.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class AllergiesScreen extends ConsumerWidget {
  const AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allergiesAsyncValue = ref.watch(allergiesProvider);
    return GenericListScreen<AllergyModel>(
      title: 'Allergies',
      asyncData: allergiesAsyncValue,
      onAddPressed: () => context.goNamed(AppRoute.addAllergy.name),
      itemBuilder: (context, allergy) {
        return SwipeToDeleteWrapper(
          itemKey: ValueKey(allergy.id),
          child: Card(
            child: ListTile(
              title: Text(allergy.allergen),
              subtitle: Text(allergy.reaction),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(allergy.severity.name),
                  8.heightBox,
                  Text(
                    DateFormat(' d/M/y').format(allergy.diagnosedDate),
                  ),
                ],
              ),
            ),
          ),
          onConfirmDelete: () async {
            try {
              await client.allergy.removeAllergies([allergy.id!]);
              ref.invalidate(allergiesProvider);
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
