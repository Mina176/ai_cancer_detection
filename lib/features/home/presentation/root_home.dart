import 'package:cancer_ai_detection/widgets/drawer_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootHome extends StatelessWidget {
  const RootHome({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return Scaffold(
            body: Row(
              children: [
                SizedBox(
                  width: 250,
                  child: DrawerContent(
                    navigationShell: navigationShell,
                  ),
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: navigationShell),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: navigationShell,
            appBar: AppBar(),
            endDrawer: Drawer(
              child: DrawerContent(
                navigationShell: navigationShell,
              ),
            ),
          );
        }
      },
    );
  }
}
