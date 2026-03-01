// Inside the extension, 'this' refers to the BuildContext
import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  bool get isLandscape =>
      MediaQuery.sizeOf(this).width > MediaQuery.sizeOf(this).height;
}
