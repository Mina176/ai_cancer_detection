import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = client.userProfileEdit.get();
    return Scaffold(
      appBar: context.isLandscape
          ? null
          : AppBar(
              forceMaterialTransparency: true,
              title: const Text('Settings'),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kHorizontalPadding,
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: context.bodyMedium?.extraBold,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
      // mobile
    );
  }
}
