import 'package:flutter/material.dart';

class SwipeToDeleteWrapper extends StatelessWidget {
  final Key itemKey;
  final Widget child;
  final Future<bool> Function() onConfirmDelete;

  const SwipeToDeleteWrapper({
    super.key,
    required this.itemKey,
    required this.child,
    required this.onConfirmDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: itemKey,
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) => onConfirmDelete(),
      child: child,
    );
  }
}
