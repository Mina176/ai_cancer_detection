import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigninScreenDesktop extends StatelessWidget {
  const SigninScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: SigninLeftSideImage()),
          Expanded(flex: 2, child: SigninSection()),
        ],
      ),
    );
  }
}

class SigninLeftSideImage extends StatelessWidget {
  const SigninLeftSideImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: Image.asset(
            'assets/signin_image.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          left: 40,
          child: Column(
            children: [
              Text(
                'Empowering\nDiagnostics with AI',
                style: context.displaySmall?.extraBold.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SigninSection extends StatefulWidget {
  const SigninSection({super.key});

  @override
  State<SigninSection> createState() => _SigninSectionState();
}

class _SigninSectionState extends State<SigninSection> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 18,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back',
            style: context.headlineMedium?.extraBold,
          ),
          Text(
            'Sign in to continue your journey towards early cancer detection.',
            style: context.bodyMedium,
          ),
          TextField(
            onChanged: (value) => setState(() => email = value),
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          TextField(
            onChanged: (value) => setState(() => password = value),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            label: Icon(Icons.arrow_forward),
            icon: Text("Sign In"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Don't have an account?  "),
                    TextSpan(
                      text: 'Sign Up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go(signupRoute),
                      style: context.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 160),
    );
  }
}
