import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.profile,
    this.radius = 50,
  });

  final UserProfileModel profile;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(
        profile.imageUrl != null
            ? '${profile.imageUrl!.toString().replaceAll(
                'http://localhost:6000',
                'https://gp-api.lasheen.dev',
              )}&v=${DateTime.now().millisecondsSinceEpoch}'
            : 'https://ui-avatars.com/api/?name=${profile.fullName ?? 'User'}&size=200&background=2B9DEE&color=fff',
      ),
    );
  }
}
