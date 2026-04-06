import 'package:flutter/material.dart';

class ScanOption extends StatelessWidget {
  const ScanOption({
    super.key,
    required this.model,
  });

  final QuickActionModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          DecoratedBox(
            decoration: ShapeDecoration(
              color: const Color(0xFFDBEAFE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                model.icon,
                color: const Color(0xff0EA5E9),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              model.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
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
