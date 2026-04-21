import 'package:cancer_ai_detection/src/features/patient/select_doctor/controller/choose_doctor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class ChooseDoctorScreen extends ConsumerWidget {
  const ChooseDoctorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewStateAsync = ref.watch(chooseDoctorControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Doctor'),
      ),
      body: viewStateAsync.when(
        data: (viewState) {
          final yourDoctors = viewState.filteredYourDoctors;
          final allDoctors = viewState.filteredAllDoctors;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            children: [
              TextField(
                onChanged: (value) {
                  ref
                      .read(chooseDoctorControllerProvider.notifier)
                      .setSearchQuery(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search doctors',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _SectionTitle(
                title: 'Your Doctors',
                count: yourDoctors.length,
              ),
              const SizedBox(height: 8),
              if (yourDoctors.isEmpty)
                const _EmptySection(
                  message: 'No doctors selected yet.',
                )
              else
                ...yourDoctors.map(
                  (doctor) => _DoctorTile(
                    doctor: doctor,
                    isSelected: true,
                    onToggle: () => _onToggleDoctor(context, ref, doctor.id),
                  ),
                ),
              const SizedBox(height: 18),
              _SectionTitle(
                title: 'All Doctors',
                count: allDoctors.length,
              ),
              const SizedBox(height: 8),
              if (allDoctors.isEmpty)
                const _EmptySection(
                  message: 'No doctors found for this search.',
                )
              else
                ...allDoctors.map(
                  (doctor) => _DoctorTile(
                    doctor: doctor,
                    isSelected:
                        doctor.id != null && viewState.isSelected(doctor.id!),
                    onToggle: () => _onToggleDoctor(context, ref, doctor.id),
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

  Future<void> _onToggleDoctor(
    BuildContext context,
    WidgetRef ref,
    UuidValue? doctorId,
  ) async {
    if (doctorId == null) {
      return;
    }

    final success = await ref
        .read(chooseDoctorControllerProvider.notifier)
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
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

class _DoctorTile extends StatelessWidget {
  const _DoctorTile({
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

class _EmptySection extends StatelessWidget {
  const _EmptySection({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(message),
    );
  }
}
