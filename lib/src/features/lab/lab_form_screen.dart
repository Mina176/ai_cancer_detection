import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/sticky_bottom_form_layout.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_profile_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LabFormScreen extends ConsumerStatefulWidget {
  const LabFormScreen({super.key});

  @override
  ConsumerState<LabFormScreen> createState() => _LabFormScreenState();
}

class _LabFormScreenState extends ConsumerState<LabFormScreen> {
  final formKey = GlobalKey<FormState>();
  String? name;
  String? labType;
  String? address;
  String? phone;

  Future<void> onSaved() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    final existingProfile = await ref.read(labProfileProvider.future);
    await client.labProfile.update(
      name: name ?? existingProfile.name,
      labType: labType ?? existingProfile.labType,
      address: address ?? existingProfile.address,
      phone: phone ?? existingProfile.phone,
    );

    ref.invalidate(labProfileProvider);
    if (!mounted) return;
    if (GoRouter.of(context).canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoute.home.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(labProfileProvider);
    return Scaffold(
      body: profileAsync.when(
        data: (profile) => StickyBottomFormLayout(
          title: 'Lab Form',
          formContent: Form(
            key: formKey,
            child: Column(
              spacing: 8,
              children: [
                TextFormField(
                  initialValue: profile.name ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Lab Name',
                  ),
                  onChanged: (value) => name = value,
                ),
                TextFormField(
                  initialValue: profile.labType ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Lab Type',
                  ),
                  onChanged: (value) => labType = value,
                ),
                TextFormField(
                  initialValue: profile.address ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  onChanged: (value) => address = value,
                ),
                TextFormField(
                  initialValue: profile.phone ?? '',
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                  onChanged: (value) => phone = value,
                ),
              ],
            ),
          ),
          onSave: onSaved,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
