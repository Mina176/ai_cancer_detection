import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadCard extends StatelessWidget {
  const UploadCard({
    super.key,
    required this.fileBytes,
    required this.fileName,
    required this.onPickFile,
    required this.onCancel,
  });

  final Uint8List? fileBytes;
  final String? fileName;
  final VoidCallback onPickFile;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return fileBytes == null
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FAFE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      32.heightBox,
                      const Icon(
                        Icons.cloud_upload_rounded,
                        size: 48,
                        color: Colors.blue,
                      ),
                      24.heightBox,
                      Text(
                        'Drag and drop medical scans',
                        style: context.bodyLarge?.extraBold,
                      ),
                      8.heightBox,
                      Text(
                        'Supports DICOM & PNG files',
                        style: context.bodyMedium?.copyWith(
                          color: context.theme.hintColor,
                        ),
                      ),
                      24.heightBox,
                      TextButton(
                        onPressed: onPickFile,
                        style: TextButton.styleFrom(
                          minimumSize: const Size(160, 48),
                        ),
                        child: const Text('Browse Files'),
                      ),
                      32.heightBox,
                    ],
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.primaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: 300,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.description_outlined,
                            size: 64,
                            color: Colors.white,
                          ),
                          16.heightBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              fileName ?? 'Selected DICOM file',
                              textAlign: TextAlign.center,
                              style:
                                  (context.bodyLarge?.extraBold ??
                                          const TextStyle())
                                      .copyWith(color: Colors.white),
                            ),
                          ),
                          8.heightBox,
                          Text(
                            'DICOM file ready to upload',
                            style: context.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: onCancel,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
