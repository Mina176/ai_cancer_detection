import 'package:cancer_ai_detection/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class GenericListScreen<T> extends StatelessWidget {
  final String title;
  final AsyncValue<List<T>> asyncData;
  final VoidCallback onAddPressed;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const GenericListScreen({
    super.key,
    required this.title,
    required this.asyncData,
    required this.onAddPressed,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        child: const Icon(Icons.add),
      ),
      appBar: context.isLandscape ? null : AppBar(title: Text(title)),
      body: asyncData.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Text(
                'No $title added yet.\nTap the + button to add.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.kHorizontalPadding,
              vertical: context.isLandscape ? Sizes.kVerticalPadding : 0,
            ),
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  itemBuilder(context, items[index]),
              separatorBuilder: (context, index) => 6.heightBox,
            ),
          );
        },
        error: (error, _) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
