import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';

abstract interface class ActionModel {
  String get title;
  IconData get icon;
  AppRoute get route;
}
