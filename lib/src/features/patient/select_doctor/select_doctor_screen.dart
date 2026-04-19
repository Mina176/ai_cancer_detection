import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/swipe_to_delete_wrapper.dart';
import 'package:cancer_ai_detection/src/features/patient/pateint_doctors/controller/list_my_doctors.dart';
import 'package:cancer_ai_detection/src/features/patient/pateint_doctors/controller/get_all_doctors.dart';
import 'package:cancer_ai_detection/src/theming/app_theme.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class SelectDoctorScreen extends ConsumerStatefulWidget {
  const SelectDoctorScreen({super.key});

  @override
  ConsumerState<SelectDoctorScreen> createState() => _SelectDoctorState();
}

class _SelectDoctorState extends ConsumerState<SelectDoctorScreen> {
  bool isSearching = false;
  String searchQuery = '';
  final Set<String> _loadingDoctorIds = <String>{};

  Future<void> _addDoctor(UuidValue? doctorId) async {
    if (doctorId == null) return;
    final id = doctorId.toString();
    if (_loadingDoctorIds.contains(id)) return;
    setState(() {
      _loadingDoctorIds.add(id);
    });
    try {
      await client.patientDoctor.addDoctor(doctorId);
      ref.invalidate(listMyDoctorsProvider);
      ref.invalidate(getAllDoctorsProvider);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not add doctor. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loadingDoctorIds.remove(id);
        });
      }
    }
  }

  Future<bool> _removeDoctor(UuidValue doctorId) async {
    final id = doctorId.toString();
    if (_loadingDoctorIds.contains(id)) return false;
    setState(() {
      _loadingDoctorIds.add(id);
    });
    try {
      await client.patientDoctor.removeDoctor(doctorId);
      ref.invalidate(listMyDoctorsProvider);
      ref.invalidate(getAllDoctorsProvider);
      return true;
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not remove doctor. Please try again.'),
          ),
        );
      }
      return false;
    } finally {
      if (mounted) {
        setState(() {
          _loadingDoctorIds.remove(id);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorsAsync = ref.watch(getAllDoctorsProvider);
    final selectedDoctorsAsync = ref.watch(listMyDoctorsProvider);
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search doctor',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              )
            : const Text('Choose Your Doctor'),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                searchQuery = '';
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: selectedDoctorsAsync.when(
          data: (selectedDoctors) {
            return doctorsAsync.when(
              data: (allDoctors) {
                final query = searchQuery.toLowerCase();
                final selectedDoctorIds = selectedDoctors
                    .map((doctor) => doctor.doctorId)
                    .toSet();

                final filteredSelected = selectedDoctors.where((doctorPatient) {
                  final name =
                      doctorPatient.doctor?.fullName?.toLowerCase() ?? '';
                  return name.contains(query);
                }).toList();

                final filteredAvailable = allDoctors.where((doctor) {
                  final name = doctor.fullName?.toLowerCase() ?? '';
                  final doctorId = doctor.id;
                  if (doctorId == null) return false;
                  return !selectedDoctorIds.contains(doctorId) &&
                      name.contains(query);
                }).toList();

                return ListView(
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      'Selected Doctors',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    if (filteredSelected.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No selected doctors found.'),
                        ),
                      ),
                    ...filteredSelected.map((doctorPatient) {
                      final doctor = doctorPatient.doctor;
                      final doctorId = doctorPatient.doctorId;
                      final isLoading = _loadingDoctorIds.contains(
                        doctorId.toString(),
                      );

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SwipeToDeleteWrapper(
                          itemKey: ValueKey(doctorId),
                          onConfirmDelete: () => _removeDoctor(doctorId),
                          child: Card(
                            child: ListTile(
                              title: Text(doctor?.fullName ?? 'Unknown doctor'),
                              subtitle: Text(doctorId.toString()),
                              trailing: isLoading
                                  ? Container(
                                      margin: EdgeInsets.only(right: 16),
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await _removeDoctor(doctorId);
                                      },
                                    ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Text(
                      'All Doctors',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    if (filteredAvailable.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No available doctors found.'),
                        ),
                      ),
                    ...filteredAvailable.map((doctor) {
                      final doctorId = doctor.id;
                      final isLoading = _loadingDoctorIds.contains(
                        doctorId.toString(),
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.transparent,
                              width: 0.8,
                            ),
                          ),
                          child: ListTile(
                            title: Text(doctor.fullName ?? 'Unknown doctor'),
                            subtitle: Text(doctor.authUserId.toString()),
                            trailing: isLoading
                                ? Container(
                                    margin: EdgeInsets.only(right: 16),
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: AppTheme.primaryColor,
                                    ),
                                    onPressed: () => _addDoctor(doctorId),
                                  ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                );
              },
              error: (error, stackTrace) => const Center(
                child: Text('Failed to load doctors.'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          error: (error, stackTrace) => const Center(
            child: Text('Failed to load selected doctors.'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
