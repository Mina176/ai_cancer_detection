import 'package:cancer_ai_detection/src/features/patient/patient_lab/controller/select_lab_controller.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class SelectLabScreen extends ConsumerWidget {
  const SelectLabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewStateAsync = ref.watch(selectLabControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Lab'),
      ),
      body: viewStateAsync.when(
        data: (viewState) {
          final yourLabs = viewState.filteredYourLabs;
          final allLabs = viewState.filteredAllLabs;
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
            ),
            children: [
              TextField(
                onChanged: (value) => ref
                    .read(selectLabControllerProvider.notifier)
                    .setSearchQuery(value),
                decoration: const InputDecoration(
                  hintText: 'Search labs',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 18),
              SectionTitle(
                title: 'Your Labs',
                count: yourLabs.length,
              ),
              const SizedBox(height: 8),
              if (yourLabs.isEmpty)
                const EmptySection(
                  message: 'No labs selected...',
                )
              else
                ...yourLabs.map(
                  (lab) => LabTile(
                    lab: lab,
                    isSelected: true,
                    onToggle: () => onToggleLab(context, ref, lab.id),
                  ),
                ),
              const SizedBox(height: 18),
              SectionTitle(
                title: 'All Labs',
                count: allLabs.length,
              ),
              const SizedBox(height: 8),
              if (allLabs.isEmpty)
                const EmptySection(
                  message: 'No labs found...',
                )
              else
                ...allLabs.map(
                  (lab) => LabTile(
                    lab: lab,
                    isSelected: lab.id != null && viewState.isSelected(lab.id!),
                    onToggle: () => onToggleLab(context, ref, lab.id),
                  ),
                ),
            ],
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> onToggleLab(
    BuildContext context,
    WidgetRef ref,
    UuidValue? labId,
  ) async {
    if (labId == null) return;

    final success = await ref
        .read(selectLabControllerProvider.notifier)
        .toggleLab(labId);

    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not update lab selection.'),
        ),
      );
    }
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text('$count'),
          ),
        ),
      ],
    );
  }
}

class LabTile extends StatelessWidget {
  const LabTile({
    super.key,
    required this.lab,
    required this.isSelected,
    required this.onToggle,
  });

  final LabProfileModel lab;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final locationLabel = lab.address ?? 'Address not set';
    final patientsCount = lab.patients?.length ?? 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(lab.name ?? 'Unnamed lab'),
        subtitle: Text('$locationLabel • $patientsCount Patients associated'),
        trailing: IconButton(
          onPressed: onToggle,
          icon: Icon(isSelected ? Icons.remove_circle : Icons.add_circle),
          color: isSelected
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
          tooltip: isSelected ? 'Remove lab' : 'Add lab',
        ),
      ),
    );
  }
}

class EmptySection extends StatelessWidget {
  const EmptySection({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(message),
    );
  }
}
