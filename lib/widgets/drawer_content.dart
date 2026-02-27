import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatefulWidget {
  const DrawerContent({super.key});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      'Home',
      'Scan',
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
                  selected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
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
