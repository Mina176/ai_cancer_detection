import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/features/home/presentation/home_body_desktop.dart';
import 'package:cancer_ai_detection/features/home/presentation/home_body_mobile.dart';
import 'package:cancer_ai_detection/widgets/responsive_builder.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: HomeBodyMobile(),
      desktop: HomeBodyDesktop(),
    );
  }
}
