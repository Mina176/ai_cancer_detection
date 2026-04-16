import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/features/user_role_selection/controller/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class DrawerContent extends ConsumerWidget {
  const DrawerContent({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  void onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> menuItems = [
      'Home',
      'Scan ',
      'Settings',
    ];
    List<IconData> menuIcons = [
      Icons.home,
      Icons.qr_code_scanner_rounded,
      Icons.settings,
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
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await client.auth.signOutDevice();
              ref.read(userRoleProvider.notifier).setRole(null);
            },
          ),
        ),
        16.heightBox,
      ],
    );
  }
}
