import 'dart:typed_data';

import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:flutter/material.dart';
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

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = client.userProfileEdit.get();
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
                  FutureBuilder(
                    future: user,
                    builder: (context, asyncSnapshot) {
                      return Text(
                        asyncSnapshot.data?.fullName ?? '',
                        style: context.bodyMedium?.bold,
                      );
                    },
                  ),
                ],
              )
            : FutureBuilder(
                future: user,
                builder: (context, asyncSnapshot) {
                  return CircleAvatar(
                    radius: 20,
                    child: asyncSnapshot.data?.imageUrl != null
                        ? Image.network(
                            asyncSnapshot.data!.imageUrl!.toString(),
                            fit: BoxFit.cover,
                          )
                        : Text(
                            asyncSnapshot.data?.fullName != null
                                ? asyncSnapshot.data!.fullName!
                                      .split(' ')
                                      .map((e) => e[0])
                                      .take(2)
                                      .join()
                                : 'User'
                                      .split(' ')
                                      .map((e) => e[0])
                                      .take(2)
                                      .join(),
                          ),
                  );
                },
              ),
      ),
    );
  }
}
