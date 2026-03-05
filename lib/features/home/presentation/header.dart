import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:flutter/material.dart';

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
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Text('JD'),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Dr.Reynolds',
                    style: context.bodyMedium?.bold,
                  ),
                ],
              )
            : Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text('JD'),
                  ),
                ],
              ),
      ),
    );
  }
}
