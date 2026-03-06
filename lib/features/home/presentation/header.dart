import 'dart:typed_data';

import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cancer_ai_detection/features/settings/data/profile_provider.dart';
import 'package:cancer_ai_detection/features/settings/presentation/settings_screen.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/theming/app_theme.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Greeting(),
        UserCard(),
      ],
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Good Morning', style: context.headlineMedium?.extraBold),
        Text("Ready to start today's diagnostics?"),
      ],
    );
  }
}

class UserCard extends ConsumerWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: const Color(0xFFF3F4F6),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: context.isLandscape
            ? Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text(''),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  userProfileAsync.when(
                    data: (profile) => ProfileImage(
                      profile: profile,
                      radius: 20,
                    ),
                    loading: () => CircleAvatar(
                      radius: 20,
                      child: Text(''),
                    ),
                    error: (error, stack) => CircleAvatar(
                      radius: 20,
                      child: Text(''),
                    ),
                  ),
                ],
              )
            : userProfileAsync.when(
                data: (profile) => GestureDetector(
                  onTap: () => context.go(settingsRoute),
                  child: ProfileImage(
                    profile: profile,
                    radius: 20,
                  ),
                ),
                loading: () => CircleAvatar(
                  radius: 20,
                  child: Text(''),
                ),
                error: (error, stack) => CircleAvatar(
                  radius: 20,
                  child: Text(''),
                ),
              ),
      ),
    );
  }
}
