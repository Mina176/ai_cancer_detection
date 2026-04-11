import 'package:cancer_ai_detection/src/enums/patient_quick_action.dart';
import 'package:cancer_ai_detection/src/features/home/widgets/header.dart';
import 'package:cancer_ai_detection/src/features/home/widgets/quick_action.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
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
                    'Quick Scan',
                    style: context.bodyMedium?.extraBold,
                  ),
                  8.heightBox,
                ],
              ),
            ),
            SliverFillRemaining(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.isLandscape ? 3 : 1,
                  childAspectRatio: context.isLandscape ? 3 : 3.5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: PatientQuickAction.values.length,
                itemBuilder: (context, index) {
                  return QuickAction(
                    model: PatientQuickAction.values[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
