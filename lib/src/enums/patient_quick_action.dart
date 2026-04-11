import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';

enum PatientQuickAction {
  upload(
    title: 'Upload Scan',
    icon: Icons.upload_file,
    route: AppRoute.upload,
  ),
  allergy(
    title: 'Add Allergy',
    icon: Icons.add_circle_rounded,
    route: AppRoute.addAllergy,
  ),
  medication(
    title: 'Add Medication',
    icon: Icons.medication_rounded,
    route: AppRoute.addMedication,
  ),
  medicalHistory(
    title: 'Add Medical History',
    icon: Icons.history_toggle_off_rounded,
    route: AppRoute.addMedicalHistory,
  ),
  healthMeasurements(
    title: 'Add Health Measurements',
    icon: Icons.monitor_heart_rounded,
    route: AppRoute.addHealthMeasurement,
  )
  ;

  final String title;
  final IconData icon;
  final AppRoute route;

  const PatientQuickAction({
    required this.title,
    required this.icon,
    required this.route,
  });
}
