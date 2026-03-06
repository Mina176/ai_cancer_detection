import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllergiesScreen extends StatelessWidget {
  const AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('$settingsRoute/$allergiesRoute/$addAllergyRoute');
        },
        child: const Icon(Icons.add),
      ),
      appBar: context.isLandscape
          ? null
          : AppBar(
              title: const Text('Allergies'),
            ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Allergy Name'),
            subtitle: Text('Details about the allergy'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('High'),
                8.heightBox,
                Text('2024-06-01'),
              ],
            ),
          );
        },
      ),
    );
  }
}
