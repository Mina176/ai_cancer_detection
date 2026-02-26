import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: DrawerContent()),
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
