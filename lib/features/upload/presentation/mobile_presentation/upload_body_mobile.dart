import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/constants.dart';
import 'package:cancer_ai_detection/features/upload/data/prediction.dart';
import 'package:cancer_ai_detection/features/upload/presentation/desktop_presentation/scan_data_section.dart';
import 'package:cancer_ai_detection/features/upload/presentation/desktop_presentation/upload_scan_section.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadBodyMobile extends StatefulWidget {
  const UploadBodyMobile({super.key});

  @override
  State<UploadBodyMobile> createState() => _UploadBodyMobileState();
}

class _UploadBodyMobileState extends State<UploadBodyMobile> {
  File? selectedImage;
  bool isLoading = false;
  Prediction? result;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 224,
      maxHeight: 224,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        result = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Upload Scan'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UploadCard(
                    selectedImage: selectedImage,
                    onPickImage: pickImage,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      16.heightBox,
                      Text(
                        'Scan Type',
                        style: context.bodyMedium?.bold,
                      ).paddingSymmetric(horizontal: 16),
                      8.heightBox,
                      DropdownButtonFormField(
                        items: ['CT Scan', 'MRI', 'X-Ray']
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Select scan type',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.theme.hintColor,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 16),
                      16.heightBox,
                      Text(
                        'Date of Scan',
                        style: context.bodyMedium?.bold,
                      ).paddingSymmetric(horizontal: 16),
                      8.heightBox,
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {},
                          ),
                          hintText: 'dd/mm/yyyy',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.theme.hintColor,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 16),
                      16.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Clinical Notes',
                            style: context.bodyMedium?.bold,
                          ),
                          Text(
                            'Optional',
                            style: context.bodyMedium?.copyWith(
                              color: context.theme.hintColor,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16),
                      8.heightBox,
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                              'Enter relevant symptoms, history, or specific areas of concern...',
                          hintStyle: context.bodyMedium?.copyWith(
                            color: context.theme.hintColor,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 16),
                    ],
                  ).paddingSymmetric(vertical: Sizes.kVerticalPadding / 2),
                ],
              ),
            ),
          ),
          Divider(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Upload'),
          ).paddingSymmetric(horizontal: 16),
          8.heightBox,
        ],
      ),
    );
  }
}
