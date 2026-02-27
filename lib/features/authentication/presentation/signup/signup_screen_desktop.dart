import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignupScreenDesktop extends StatelessWidget {
  const SignupScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SignupLeftSideImage().expanded(),
          SignupSection().expanded(flex: 2),
        ],
      ),
    );
  }
}

class SignupSection extends StatefulWidget {
  const SignupSection({super.key});

  @override
  State<SignupSection> createState() => _SignupSectionState();
}

class _SignupSectionState extends State<SignupSection> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  AuthSuccess? authInfo = client.auth.authInfo;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14,
      children: [
        Text(
          'Create Account',
          style: context.displaySmall?.extraBold,
        ),
        20.heightBox,
        Row(
          children: [
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First Name',
                  style: context.bodyMedium?.medium.bold,
                ),
                TextField(
                  onChanged: (value) => firstName = value,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ).expanded(),
            20.widthBox,
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Name',
                  style: context.bodyMedium?.medium.bold,
                ),
                TextField(
                  onChanged: (value) => lastName = value,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ).expanded(),
          ],
        ),
        Text(
          'Email',
          style: context.bodyMedium?.medium.bold,
        ),
        TextField(
          onChanged: (value) => email = value,
          decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Text(
          'Create Password',
          style: context.bodyMedium?.medium.bold,
        ),
        TextField(
          onChanged: (value) => password = value,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Create Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        8.heightBox,
        ElevatedButton(
          onPressed: () {},
          child: const Text('Create Account'),
        ),
      ],
    ).paddingSymmetric(horizontal: 160);
  }
}

class SignupLeftSideImage extends StatelessWidget {
  const SignupLeftSideImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
