import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/date_list_tile.dart';
import 'package:cancer_ai_detection/src/routing/app_router.dart';
import 'package:cancer_ai_detection/src/common_widgets/gender_selector.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  Gender? selectedGender;
  BloodType? selectedBloodType;
  String? smokingStatus;
  int? smokingYears;
  String? alcoholFrequency;
  String? exerciseFrequency;

  Future<void> onSaved() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await client.patientProfileModelEdit.update(
        dob: selectedDate,
        gender: selectedGender,
        smokingStatus: smokingStatus,
        smokingYears: smokingYears,
        alcoholFreq: alcoholFrequency,
        bloodType: selectedBloodType,
      );
      if (!mounted) return;
      context.go(homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StickyBottomFormLayout(
        title: 'Patient Form',
        formContent: Form(
          key: formKey,
          child: Column(
            spacing: 8,
            children: [
              DateListTile(
                title: 'Date of Birth',
                selectedDate: selectedDate,
                onSelectDate: (date) => setState(() => selectedDate = date),
              ),
              GenderSelector(
                selectedGender: selectedGender,
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              DropdownButtonFormField<BloodType>(
                decoration: const InputDecoration(hintText: 'Blood Type'),
                items: BloodType.values.map((type) {
                  return DropdownMenuItem<BloodType>(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  selectedBloodType = value;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Smoking Status'),
                onChanged: (value) => smokingStatus = value,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Smoking Years'),
                onChanged: (value) => smokingYears = int.tryParse(value),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Alcohol Frequency'),
                onChanged: (value) => alcoholFrequency = value,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Exercise Frequency'),
                onChanged: (value) => exerciseFrequency = value,
              ),
            ],
          ),
        ),
        onSave: () => onSaved(),
      ),
    );
  }
}
