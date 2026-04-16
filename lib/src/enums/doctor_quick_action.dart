import 'package:cancer_ai_detection/src/enums/action_model.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';

enum DoctorQuickAction implements ActionModel {
  viewPatients(
    'View Patients',
    Icons.people_alt_rounded,
    AppRoute.doctorPatients,
  ),
  ;

  @override
  final String title;
  @override
  final IconData icon;
  @override
  final AppRoute route;

  const DoctorQuickAction(
    this.title,
    this.icon,
    this.route,
  );
}
