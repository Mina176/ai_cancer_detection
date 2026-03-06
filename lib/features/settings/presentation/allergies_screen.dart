import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/settings/data/allergies_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('$settingsRoute/$allergiesRoute/$addAllergyRoute');
        },
        child: const Icon(Icons.add),
      ),
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Allergies'),
            ),
      body: allergiesAsyncValue.when(
        data: (allergies) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.kHorizontalPadding,
            vertical: context.isLandscape ? Sizes.kVerticalPadding : 0,
          ),
          child: ListView.builder(
            itemCount: allergies.length,
            itemBuilder: (context, index) =>
                DimissibleListTile(allergy: allergies[index]),
          ),
        ),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class DimissibleListTile extends ConsumerWidget {
  const DimissibleListTile({
    super.key,
    required this.allergy,
  });

  final AllergyModel allergy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(allergy.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
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
    );
  }
}
