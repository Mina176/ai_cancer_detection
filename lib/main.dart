import 'package:cancer_ai_detection/features/home/presentation/home_screen.dart';
import 'package:cancer_ai_detection/features/upload_image/presentation/upload_screen_desktop.dart';
import 'package:cancer_ai_detection/theming/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const UploadScreen(),
    );
  }
}
