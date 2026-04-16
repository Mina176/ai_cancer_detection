import 'package:cancer_ai_detection/src/enums/doctor_quick_action.dart';
import 'package:cancer_ai_detection/src/enums/patient_quick_action.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/home/widgets/header.dart';
import 'package:cancer_ai_detection/src/features/home/widgets/quick_action_card.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDoctor = ref.watch(userRoleProvider) == 'doctor';
    final profileAsync = isDoctor
        ? ref.watch(doctorProfileProvider)
        : ref.watch(patientProfileProvider);
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Home Screen'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: profileAsync.when(
        data: (_) => Padding(
          padding: EdgeInsets.only(
            left: Sizes.kHorizontalPadding,
            right: Sizes.kHorizontalPadding,
            top: context.isLandscape ? Sizes.kVerticalPadding : 0,
            bottom: Sizes.kBottomButtonPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(),
                    8.heightBox,
                    Text(
                      'Quick Actions',
                      style: context.bodyMedium?.extraBold,
                    ),
                    8.heightBox,
                  ],
                ),
              ),
              SliverFillRemaining(
                child: Consumer(
                  builder: (context, ref, child) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.isLandscape ? 3 : 1,
                        childAspectRatio: context.isLandscape ? 3 : 3.5,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: ref.read(userRoleProvider) == 'doctor'
                          ? DoctorQuickAction.values.length
                          : PatientQuickAction.values.length,
                      itemBuilder: (context, index) {
                        return QuickActionCard(
                          model: ref.read(userRoleProvider) == 'doctor'
                              ? DoctorQuickAction.values[index]
                              : PatientQuickAction.values[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
