import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/date_list_tile.dart';
import 'package:cancer_ai_detection/src/common_widgets/gender_selector.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';

class PatientFormScreen extends ConsumerStatefulWidget {
  const PatientFormScreen({super.key});

  @override
  ConsumerState<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends ConsumerState<PatientFormScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  Gender? selectedGender;
  BloodType? selectedBloodType;
  String? smokingStatus;
  int? smokingYears;
  String? alcoholFrequency;
  String? exerciseFrequency;

  Future<void> onSaved() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final existingProfile = await ref.read(patientProfileProvider.future);
      await client.patientProfile.update(
        dob: selectedDate ?? existingProfile.dob ?? DateTime.now(),
        gender: selectedGender ?? existingProfile.gender,
        smokingStatus: smokingStatus ?? existingProfile.smokingStatus,
        smokingYears: smokingYears ?? existingProfile.smokingYears,
        alcoholFreq: alcoholFrequency ?? existingProfile.alcoholFreq,
        exerciseFreq: exerciseFrequency ?? existingProfile.exerciseFreq,
        bloodType: selectedBloodType ?? existingProfile.bloodType,
      );
      if (!mounted) return;
      context.goNamed(AppRoute.home.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(patientProfileProvider);
    return Scaffold(
      body: profileAsync.when(
        data: (profile) => StickyBottomFormLayout(
          title: 'Patient Form',
          formContent: Form(
            key: formKey,
            child: Column(
              spacing: 8,
              children: [
                DateListTile(
                  title: 'Date of Birth',
                  selectedDate: selectedDate ?? profile.dob ?? DateTime.now(),
                  onSelectDate: (date) => setState(() => selectedDate = date),
                ),
                GenderSelector(
                  selectedGender: selectedGender ?? profile.gender,
                  onChanged: (value) => setState(() => selectedGender = value),
                ),
                DropdownButtonFormField<BloodType>(
                  value: selectedBloodType ?? profile.bloodType,
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
                  initialValue: profile.smokingStatus ?? '',
                  decoration: InputDecoration(hintText: 'Smoking Status'),
                  onChanged: (value) => smokingStatus = value,
                ),
                TextFormField(
                  initialValue: profile.smokingYears?.toString() ?? '',
                  decoration: InputDecoration(hintText: 'Smoking Years'),
                  onChanged: (value) => smokingYears = int.tryParse(value),
                ),
                TextFormField(
                  initialValue: profile.alcoholFreq ?? '',
                  decoration: InputDecoration(hintText: 'Alcohol Frequency'),
                  onChanged: (value) => alcoholFrequency = value,
                ),
                TextFormField(
                  initialValue: profile.exerciseFreq ?? '',
                  decoration: InputDecoration(hintText: 'Exercise Frequency'),
                  onChanged: (value) => exerciseFrequency = value,
                ),
              ],
            ),
          ),
          onSave: () => onSaved(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
