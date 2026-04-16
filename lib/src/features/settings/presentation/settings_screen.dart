import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/health_measurement/controller/health_measurement_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medical_history/controller/medical_history_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:cancer_ai_detection/src/features/patient/allergies/controllers/allergies_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/medication/controller/medication_provider.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/primary_button.dart';
import 'package:cancer_ai_detection/src/common_widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? newUserName;
  String? newFullName;

  Future<void> pickProfileImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      final uint8ListImage = await image.readAsBytes();
      final ByteData imageByteData = ByteData.view(uint8ListImage.buffer);
      final isDoctor = ref.read(userRoleProvider) == 'doctor';

      isDoctor
          ? await client.doctorProfile.update(image: imageByteData)
          : await client.patientProfile.update(image: imageByteData);

      final _ = isDoctor
          ? await ref.refresh(doctorProfileProvider.future)
          : await ref.refresh(patientProfileProvider.future);
    }
  }

  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    final isDoctor = ref.read(userRoleProvider) == 'doctor';

    if (newFullName != null && newFullName!.trim().isNotEmpty) {
      isDoctor
          ? await client.doctorProfile.update(fullName: newFullName!.trim())
          : await client.patientProfile.update(fullName: newFullName!.trim());
    }

    final _ = isDoctor
        ? ref.refresh(doctorProfileProvider)
        : ref.refresh(patientProfileProvider);

    if (mounted) context.goNamed(AppRoute.home.name);
  }

  @override
  Widget build(BuildContext context) {
    final isDoctor = ref.read(userRoleProvider) == 'doctor';
    final userProfileAsync = isDoctor
        ? ref.watch(doctorProfileProvider)
        : ref.watch(patientProfileProvider);
    final allergiesAsync = ref.watch(allergiesProvider);
    final medicationsAsync = ref.watch(medicationsProvider);
    final medicalHistoryAsync = ref.watch(medicalHistoryProvider);
    final healthMeasurementsAsync = ref.watch(healthMeasurementProvider);
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Settings'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: userProfileAsync.when(
        data: (profile) {
          final profile = userProfileAsync.value;
          final userId = isDoctor
              ? (profile as DoctorProfileModel).id
              : (profile as PatientProfileModel).id;
          final fullName = isDoctor
              ? (profile as DoctorProfileModel).fullName
              : (profile as PatientProfileModel).fullName;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.isLandscape
                  ? Sizes.kHorizontalPadding
                  : Sizes.kHorizontalPadding,
            ),
            child: Column(
              children: [
                context.isLandscape
                    ? Sizes.kVerticalPadding.heightBox
                    : 0.heightBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 14,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileImage(radius: 50),
                          TextButton(
                            onPressed: pickProfileImage,
                            child: const Text('Change Profile Picture'),
                          ),
                          TextFormField(
                            key: ValueKey(userId.toString()),
                            initialValue: userId.toString(),
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'User ID',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () => Clipboard.setData(
                                  ClipboardData(
                                    text: userId.toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            initialValue: fullName ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                            ),
                            onSaved: (value) => newFullName = value,
                          ),
                          if (!isDoctor) ...[
                            UserInfoListTile(
                              title: 'Allergires',
                              asyncData: allergiesAsync,
                              onTap: () =>
                                  context.goNamed(AppRoute.allergies.name),
                              itemLabelBuilder: (allergy) => allergy.allergen,
                            ),
                            UserInfoListTile(
                              title: 'Medications',
                              asyncData: medicationsAsync,
                              onTap: () =>
                                  context.goNamed(AppRoute.medications.name),
                              itemLabelBuilder: (medication) => medication.name,
                            ),
                            UserInfoListTile(
                              title: 'Medical History',
                              asyncData: medicalHistoryAsync,
                              onTap: () =>
                                  context.goNamed(AppRoute.medicalHistory.name),
                              itemLabelBuilder: (medicalHistory) =>
                                  medicalHistory.title,
                            ),
                            UserInfoListTile(
                              title: 'Health Measurements',
                              asyncData: healthMeasurementsAsync,
                              onTap: () => context.goNamed(
                                AppRoute.healthMeasurments.name,
                              ),
                              itemLabelBuilder: (measurement) =>
                                  '${measurement.name.name}: ${measurement.value}',
                            ),
                            1.heightBox,
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  label: 'Save Changes',
                  onPressed: saveChanges,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class UserInfoListTile<T> extends StatelessWidget {
  const UserInfoListTile({
    super.key,
    required this.title,
    required this.asyncData,
    required this.onTap,
    required this.itemLabelBuilder,
  });

  final String title;
  final AsyncValue<List<T>> asyncData;
  final VoidCallback onTap;
  final String Function(T) itemLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: asyncData.when(
          data: (data) {
            if (data.isEmpty) return const Text('None added yet');
            return Text(
              data.map(itemLabelBuilder).join(', '),
              overflow: TextOverflow.ellipsis,
            );
          },
          loading: () => const Text(''),
          error: (error, stack) => Text('Error: $error'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
