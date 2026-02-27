import 'package:cancer_ai_detection/features/authentication/presentation/signin/signin_screen_desktop.dart';
import 'package:cancer_ai_detection/features/authentication/presentation/signin/signin_screen_mobile.dart';
import 'package:cancer_ai_detection/widgets/responsive_builder.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: SigninScreenMobile(),
      desktop: SigninScreenDesktop(),
    );
  }
}
