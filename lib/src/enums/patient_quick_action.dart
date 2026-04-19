import 'package:cancer_ai_detection/src/enums/action_model.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';

enum PatientQuickAction implements ActionModel {
  allergy(
    'Add Allergy',
    Icons.add_circle_rounded,
    AppRoute.addAllergy,
  ),
  medication(
    'Add Medication',
    Icons.medication_rounded,
    AppRoute.addMedication,
  ),
  medicalHistory(
    'Add Medical History',
    Icons.history_toggle_off_rounded,
    AppRoute.addMedicalHistory,
  ),
  healthMeasurements(
    'Add Health Measurements',
    Icons.monitor_heart_rounded,
    AppRoute.addHealthMeasurement,
  ),
  chooseDoctor(
    'Choose Your Doctor',
    Icons.medical_information,
    AppRoute.chooseDoctor,
  )
  ;

  @override
  final String title;
  @override
  final IconData icon;
  @override
  final AppRoute route;

  const PatientQuickAction(
    this.title,
    this.icon,
    this.route,
  );
}
