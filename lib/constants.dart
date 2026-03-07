import 'package:flutter/material.dart';

class Sizes {
  static const double kVerticalPadding = 12.0;
  static const double kHorizontalPadding = 20.0;
  static const double kBottomButtonPadding = 8.0;
}

class AppBreakpoints {
  static const double mobile = 600.0;
  static const double desktop = 1200.0;
}

class QuickActionModel {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  QuickActionModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

List<QuickActionModel> quickActions = [
  QuickActionModel(
    title: 'Upload Scan',
    icon: Icons.medical_information,
    onTap: () {},
  ),
  QuickActionModel(
    title: 'View History',
    icon: Icons.history,
    onTap: () {},
  ),
  QuickActionModel(
    title: 'Schedule Appointment',
    icon: Icons.calendar_today,
    onTap: () {},
  ),
];
