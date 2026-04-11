import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/src/enums/action_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.model,
  });

  final ActionModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.isLandscape
          ? GoRouter.of(context).goNamed(model.route.name)
          : GoRouter.of(context).pushNamed(model.route.name),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            DecoratedBox(
              decoration: ShapeDecoration(
                color: const Color(0xFFDBEAFE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  model.icon,
                  color: const Color(0xff0EA5E9),
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                model.title,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
