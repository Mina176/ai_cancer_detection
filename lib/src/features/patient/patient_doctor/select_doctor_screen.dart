import 'package:cancer_ai_detection/src/features/patient/patient_doctor/controller/select_doctor_controller.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class SelectDoctorScreen extends ConsumerWidget {
  const SelectDoctorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewStateAsync = ref.watch(selectDoctorControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Doctor'),
      ),
      body: viewStateAsync.when(
        data: (viewState) {
          final yourDoctors = viewState.filteredYourDoctors;
          final allDoctors = viewState.filteredAllDoctors;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
            ),
            children: [
              TextField(
                onChanged: (value) => ref
                    .read(selectDoctorControllerProvider.notifier)
                    .setSearchQuery(value),
                decoration: InputDecoration(
                  hintText: 'Search doctors',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 18),
              SectionTitle(
                title: 'Your Doctors',
                count: yourDoctors.length,
              ),
              const SizedBox(height: 8),
              if (yourDoctors.isEmpty)
                const EmptySection(
                  message: 'No doctors selected...',
                )
              else
                ...yourDoctors.map(
                  (doctor) => DoctorTile(
                    doctor: doctor,
                    isSelected: true,
                    onToggle: () => onToggleDoctor(context, ref, doctor.id),
                  ),
                ),
              const SizedBox(height: 18),
              SectionTitle(
                title: 'All Doctors',
                count: allDoctors.length,
              ),
              const SizedBox(height: 8),
              if (allDoctors.isEmpty)
                const EmptySection(
                  message: 'No doctors found...',
                )
              else
                ...allDoctors.map(
                  (doctor) => DoctorTile(
                    doctor: doctor,
                    isSelected:
                        doctor.id != null && viewState.isSelected(doctor.id!),
                    onToggle: () => onToggleDoctor(context, ref, doctor.id),
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

  Future<void> onToggleDoctor(
    BuildContext context,
    WidgetRef ref,
    UuidValue? doctorId,
  ) async {
    if (doctorId == null) {
      return;
    }

    final success = await ref
        .read(selectDoctorControllerProvider.notifier)
        .toggleDoctor(doctorId);

    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not update doctor selection.'),
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

class DoctorTile extends StatelessWidget {
  const DoctorTile({
    super.key,
    required this.doctor,
    required this.isSelected,
    required this.onToggle,
  });

  final DoctorProfileModel doctor;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final yearsLabel = doctor.yearsOfExperience == null
        ? 'Experience not set'
        : '${doctor.yearsOfExperience} years experience';

    final patientsCount = doctor.patients?.length ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(doctor.fullName ?? 'Unnamed doctor'),
        subtitle: Text('$yearsLabel • $patientsCount patients'),
        trailing: IconButton(
          onPressed: onToggle,
          icon: Icon(isSelected ? Icons.remove_circle : Icons.add_circle),
          color: isSelected
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
          tooltip: isSelected ? 'Remove doctor' : 'Add doctor',
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
