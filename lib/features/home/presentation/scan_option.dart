import 'package:flutter/material.dart';

class ScanOption extends StatelessWidget {
  const ScanOption({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        margin: const EdgeInsets.only(right: 16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: const Color(0xFFDBEAFE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19.52),
                  child: Icon(
                    icon,
                    color: const Color(0xff0EA5E9),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cancer Screen',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Thoracic X-Ray Analysis',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
