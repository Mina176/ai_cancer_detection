import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:cancer_ai_detection/widgets/drawer_content.dart';
import 'package:flutter/material.dart';

class HomeBodyMobile extends StatelessWidget {
  const HomeBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Home Screen Body',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
