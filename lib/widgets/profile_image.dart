import 'package:cancer_ai_detection/features/settings/data/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({
    super.key,
    this.radius = 50,
  });

  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(userProfileProvider);
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(
        userProfileAsync.value?.imageUrl != null
            ? '${userProfileAsync.value!.imageUrl!.toString().replaceAll(
                'http://localhost:6000',
                'https://gp-api.lasheen.dev',
              )}&v=${DateTime.now().millisecondsSinceEpoch}'
            : 'https://ui-avatars.com/api/?name=${userProfileAsync.value?.fullName ?? 'User'}&size=200&background=2B9DEE&color=fff',
      ),
    );
  }
}
