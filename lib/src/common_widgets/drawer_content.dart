import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  
  void onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      'Home',
      'Scan ',
      'Settings',
      'Help',
    ];
    List<IconData> menuIcons = [
      Icons.home,
      Icons.qr_code_scanner_rounded,
      Icons.settings,
      Icons.help_outline,
    ];
    return Column(
      children: [
        16.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services_rounded,
              size: 48,
            ),
            12.widthBox,
            Text(
              'MedAI\nDiagnostics',
              style: context.headlineSmall,
            ),
          ],
        ),
        Divider(),
        ...List.generate(
          menuItems.length,
          (index) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(menuIcons[index]),
                  title: Text(menuItems[index]),
                  selected: navigationShell.currentIndex == index,
                  onTap: () => onTap(index),
                ),
                4.heightBox,
              ],
            ).paddingSymmetric(horizontal: 16);
          },
        ),
      ],
    );
  }
}
