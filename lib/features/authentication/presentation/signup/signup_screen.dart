import 'package:cancer_ai_detection/features/authentication/presentation/signup/signup_screen_desktop.dart';
import 'package:cancer_ai_detection/features/authentication/presentation/signup/signup_screen_mobile.dart';
import 'package:cancer_ai_detection/widgets/responsive_builder.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: SignupScreenMobile(),
      desktop: SignupScreenDesktop(),
    );
  }
}
