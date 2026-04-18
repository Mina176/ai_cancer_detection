import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class PatientSelectedDoctorsScreen extends StatefulWidget {
  const PatientSelectedDoctorsScreen({super.key});

  @override
  State<PatientSelectedDoctorsScreen> createState() =>
      _PatientSelectedDoctorsScreenState();
}

class _PatientSelectedDoctorsScreenState
    extends State<PatientSelectedDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Doctors'),
      ),
      body: FutureBuilder(
        future: getDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          final doctors = snapshot.data;

          if (doctors == null || doctors.isEmpty) {
            return const Center(child: Text("No Doctors are Available"));
          }
          return ListView.separated(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctorName = doctors[index].doctor!.fullName;

              return DoctorCard(
                text: doctorName!,
                onChanged: (value) {
                  if (value == true) {
                    client.patientDoctor.addDoctor(doctors[index].doctorId);
                  }
                  if (value == false) {
                    client.patientDoctor.removeDoctor(doctors[index].doctorId);
                  }
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          );
        },
      ),
    );
  }
}

class DoctorCard extends StatefulWidget {
  final String text;
  final Function(bool?) onChanged;

  const DoctorCard({
    super.key,
    required this.text,
    required this.onChanged,
  });

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const SizedBox(width: 10),

            Expanded(
              child: Text(
                widget.text,
                style: context.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
                widget.onChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<PatientDoctorModel>> getDoctors() async {
  final doctors = await client.patientDoctor.listMyDoctors();

  return doctors;
}
