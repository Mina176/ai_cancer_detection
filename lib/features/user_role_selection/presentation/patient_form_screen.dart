import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            spacing: 8,
            children: [
              ListTile(
                dense: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                    builder: (context, child) => Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 32,
                        horizontal: 16,
                      ),
                      child: child,
                    ),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                leading: Icon(Icons.calendar_month),
                title: const Text(
                  "Date",
                ),
                subtitle: Text(
                  DateFormat(' d/M/y').format(selectedDate),
                ),
              ),
              Text('Gender'),
              DropdownButtonFormField(
                decoration: InputDecoration(hintText: 'Gender'),
                items: [
                  DropdownMenuItem(value: Gender.male, child: Text('Male')),
                  DropdownMenuItem(value: Gender.female, child: Text('Female')),
                ],
                onChanged: (value) {
                  selectedGender = value;
                },
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
                decoration: InputDecoration(hintText: 'Alcohol Frequnecy'),
                onChanged: (value) => alcoholFrequency = value,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Exercise Frequnecy'),
                onChanged: (value) => exerciseFrequency = value,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    client.patientProfileModelEdit.update(
                      dob: selectedDate,
                      gender: selectedGender,
                      smokingStatus: smokingStatus,
                      smokingYears: smokingYears,
                      alcoholFreq: alcoholFrequency,
                      bloodType: selectedBloodType,
                    );
                    context.go(homeRoute);
                  }
                },
                child: Text('submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
