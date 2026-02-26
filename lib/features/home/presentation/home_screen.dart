import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/features/home/presentation/desktop_screen_body.dart';
import 'package:cancer_ai_detection/features/home/presentation/home_screen_body.dart';
import 'package:cancer_ai_detection/widgets/responsive_builder.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: HomeScreenBody(),
      desktop: DesktopScreenBody(),
    );
  }
}

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
      'Profile',
      'Settings',
      'Help',
    ];
    List<IconData> menuIcons = [
      Icons.home,
      Icons.person,
      Icons.settings,
      Icons.help_outline,
    ];
    return SizedBox(
      width: 220,
      child: Column(
        children: [
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
                style: context.headlineMedium,
              ),
            ],
          ),
          Divider(),
          ...List.generate(
            menuItems.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListTile(
                leading: Icon(menuIcons[index]),
                title: Text(menuItems[index]),
                selected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
