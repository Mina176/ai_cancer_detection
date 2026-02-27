import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:cancer_ai_detection/widgets/drawer_content.dart';
import 'package:flutter/material.dart';

class HomeBodyDesktop extends StatelessWidget {
  const HomeBodyDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Desktop Screen Body',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
