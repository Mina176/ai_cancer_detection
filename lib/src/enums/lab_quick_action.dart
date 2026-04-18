import 'package:cancer_ai_detection/src/enums/action_model.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';

enum LabQuickAction implements ActionModel {
  viewPatients(
    'View Patients',
    Icons.people_outline_rounded,
    AppRoute.labPatients,
  ),
  ;

  @override
  final String title;
  @override
  final IconData icon;
  @override
  final AppRoute route;

  const LabQuickAction(
    this.title,
    this.icon,
    this.route,
  );
}
