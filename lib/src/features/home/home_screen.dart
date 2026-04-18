import 'package:cancer_ai_detection/src/enums/doctor_quick_action.dart';
import 'package:cancer_ai_detection/src/enums/lab_quick_action.dart';
import 'package:cancer_ai_detection/src/enums/patient_quick_action.dart';
import 'package:cancer_ai_detection/src/features/doctor/profile/doctor_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/home/widgets/header.dart';
import 'package:cancer_ai_detection/src/features/home/widgets/quick_action_card.dart';
import 'package:cancer_ai_detection/src/features/lab/controller/lab_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/patient/profile/patient_profile_provider.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cancer_ai_detection/src/enums/action_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final role = ref.watch(userRoleProvider);
    final isDoctor = role == 'doctor';
    final isLabSpecialist = role == 'labSpecialist';
    final quickActions = _getQuickActions(role);
    final profileAsync = isDoctor
        ? ref.watch(doctorProfileProvider)
        : isLabSpecialist
        ? ref.watch(labProfileProvider)
        : ref.watch(patientProfileProvider);
    Widget content = Padding(
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
                  itemCount: quickActions.length,
                  itemBuilder: (context, index) {
                    return QuickActionCard(
                      model: quickActions[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
    content = profileAsync.when(
      data: (_) => content,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Home Screen'),
            ),
      body: content,
    );
  }

  List<ActionModel> _getQuickActions(String? role) {
    if (role == 'doctor') {
      return DoctorQuickAction.values;
    }
    if (role == 'labSpecialist') {
      return LabQuickAction.values;
    }
    return PatientQuickAction.values;
  }
}
