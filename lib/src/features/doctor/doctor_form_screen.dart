import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
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
    final existingProfile = await ref.read(doctorProfileProvider.future);
    await client.doctorProfile.update(
      specialization: specialization ?? existingProfile.specialization,
      licenseNumber: licenseNumber ?? existingProfile.licenseNumber,
      hospitalName: hospitalName ?? existingProfile.hospitalName,
      yearsOfExperience: yearsOfExperience ?? existingProfile.yearsOfExperience,
      phone: phone ?? existingProfile.phone,
      bio: bio ?? existingProfile.bio,
    );
    ref.invalidate(doctorProfileProvider);
    if (!mounted) return;
    if (GoRouter.of(context).canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoute.home.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(doctorProfileProvider);
    return Scaffold(
      body: profileAsync.when(
        data: (profile) => StickyBottomFormLayout(
          title: 'Doctor Form',
          formContent: Form(
            key: formKey,
            child: Column(
              spacing: 8,
              children: [
                TextFormField(
                  initialValue: profile.specialization ?? '',
                  decoration: InputDecoration(hintText: 'Specialization'),
                  onChanged: (value) => specialization = value,
                ),
                TextFormField(
                  initialValue: profile.licenseNumber ?? '',
                  decoration: InputDecoration(hintText: 'License Number'),
                  onChanged: (value) => licenseNumber = value,
                ),
                TextFormField(
                  initialValue: profile.hospitalName ?? '',
                  decoration: InputDecoration(hintText: 'Hospital Name'),
                  onChanged: (value) => hospitalName = value,
                ),
                TextFormField(
                  initialValue: profile.yearsOfExperience?.toString() ?? '',
                  decoration: InputDecoration(hintText: 'Years of Experience'),
                  onChanged: (value) => yearsOfExperience = int.tryParse(value),
                ),
                TextFormField(
                  initialValue: profile.phone ?? '',
                  decoration: InputDecoration(hintText: 'Phone'),
                  onChanged: (value) => phone = value,
                ),
                TextFormField(
                  initialValue: profile.bio ?? '',
                  decoration: InputDecoration(hintText: 'Bio'),
                  onChanged: (value) => bio = value,
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
