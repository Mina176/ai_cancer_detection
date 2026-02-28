import 'package:cancer_ai_detection/features/upload/presentation/desktop_presentation/upload_body_desktop.dart';
import 'package:cancer_ai_detection/features/upload/presentation/mobile_presentation/upload_body_mobile.dart';
import 'package:cancer_ai_detection/widgets/responsive_builder.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: UploadBodyMobile(),
      desktop: UploadBodyDesktop(),
    );
  }
}
