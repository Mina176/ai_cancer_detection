import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorFormScreen extends ConsumerStatefulWidget {
  const DoctorFormScreen({super.key});

  @override
  ConsumerState<DoctorFormScreen> createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends ConsumerState<DoctorFormScreen> {
  final formKey = GlobalKey<FormState>();
  String? specialization;
  String? licenseNumber;
  String? hospitalName;
  int? yearsOfExperience;
  String? phone;
  String? bio;

  Future<void> onSaved() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    await client.doctorProfile.update(
      specialization: specialization,
      licenseNumber: licenseNumber,
      hospitalName: hospitalName,
      yearsOfExperience: yearsOfExperience,
      phone: phone,
      bio: bio,
    );
    if (!mounted) return;
    context.goNamed(AppRoute.home.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StickyBottomFormLayout(
        title: 'Doctor Form',
        formContent: Form(
          key: formKey,
          child: Column(
            spacing: 8,
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Specialization'),
                onChanged: (value) => specialization = value,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'License Number'),
                onChanged: (value) => licenseNumber = value,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Hospital Name'),
                onChanged: (value) => hospitalName = value,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Years of Experience'),
                onChanged: (value) => yearsOfExperience = int.tryParse(value),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Phone'),
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Bio'),
                onChanged: (value) => bio = value,
              ),
            ],
          ),
        ),
        onSave: () => onSaved(),
      ),
    );
  }
}
