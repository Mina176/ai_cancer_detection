import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/generic_list_screen.dart';
import 'package:cancer_ai_detection/src/common_widgets/swipe_to_delete_wrapper.dart';
import 'package:cancer_ai_detection/src/features/patient/pateint_doctors/controller/patient_doctors_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatientSelectedDoctorsScreen extends ConsumerStatefulWidget {
  const PatientSelectedDoctorsScreen({super.key});

  @override
  ConsumerState<PatientSelectedDoctorsScreen> createState() =>
      _PatientSelectedDoctorsScreenState();
}

class _PatientSelectedDoctorsScreenState
    extends ConsumerState<PatientSelectedDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GenericListScreen(
        title: 'Your Doctors',
        asyncData: ref.watch(patientDoctorsProvider),

        onAddPressed: () => context.goNamed(AppRoute.chooseDoctor.name),
        itemBuilder: (context, doctorPatient) => SwipeToDeleteWrapper(
          itemKey: ValueKey(doctorPatient.doctorId),
          onConfirmDelete: () async {
            try {
              await client.patientDoctor.removeDoctor(doctorPatient.doctorId);
              ref.invalidate(patientDoctorsProvider);
              return true;
            } on Exception catch (e) {
              print(e);
              return false;
            }
          },
          child: Card(
            child: ListTile(
              title: Text(doctorPatient.doctor!.fullName!),
              subtitle: Text(doctorPatient.doctor!.id.toString()),
              trailing: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .end,

                children: [
                  Text(
                    '${doctorPatient.doctor!.yearsOfExperience!.toString()} Years',
                  ),
                  8.heightBox,
                  Text(
                    doctorPatient.doctor!.patients?.length.toString() ??
                        'No patients',
                  ),
                ],
              ),
            ),
          ),
        ),
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
