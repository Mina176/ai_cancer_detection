import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/features/patient/pateint_doctors/controller/select_doctors_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class ChooseDoctorScreen extends ConsumerStatefulWidget {
  const ChooseDoctorScreen({super.key});

  @override
  ConsumerState<ChooseDoctorScreen> createState() => _ChooseDoctorState();
}

class _ChooseDoctorState extends ConsumerState<ChooseDoctorScreen> {
  UuidValue? selectedDoctorId;
  bool isSearching = false;
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final doctorsAsync = ref.watch(selectDoctorsProvider);

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
      body: doctorsAsync.when(
        data: (doctors) {
          final filteredDoctors = doctors.where((doctor) {
            final name = doctor.fullName?.toLowerCase() ?? '';
            return name.contains(searchQuery.toLowerCase());
          }).toList();

          if (filteredDoctors.isEmpty) {
            return const Center(
              child: Text('No doctors found'),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              final doctor = filteredDoctors[index];

              return Card(
                child: ListTile(
                  title: Text(doctor.fullName!),
                  subtitle: Text(doctor.authUserId.toString()),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        doctor.yearsOfExperience != null
                            ? '${doctor.yearsOfExperience} Years'
                            : '',
                      ),
                      8.heightBox,
                      Text(
                        doctor.patients?.length.toString() ?? 'No patients',
                      ),
                    ],
                  ),
                  onTap: () async {
                    selectedDoctorId = doctor.id;
                    await client.patientDoctor.addDoctor(selectedDoctorId!);
                  },
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => const Center(
          child: CircularProgressIndicator(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
