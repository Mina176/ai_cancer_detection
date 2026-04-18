import 'package:awesome_extensions/awesome_extensions.dart';
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
  @override
  Widget build(BuildContext context) {
    final doctorsAsync = ref.watch(selectDoctorsProvider);

    return Scaffold(
      body: doctorsAsync.when(
        data: (doctors) {
          print(doctors);
          if (doctors.isEmpty) {
            return Center(child: Text('No doctors Availabe now try again'));
          }
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return Card(
                child: ListTile(
                  title: Text(doctor.fullName!),
                  subtitle: Text(doctor.specialization!),
                  trailing: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .end,
                    children: [
                      Text(
                        '${doctor.yearsOfExperience!.toString()} Years',
                      ),
                      8.heightBox,
                      Text(
                        doctor.patients?.length.toString() ?? 'No patients',
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      selectedDoctorId = doctor.authUserId;
                    });
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
