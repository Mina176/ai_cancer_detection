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
