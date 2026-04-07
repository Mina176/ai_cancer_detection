import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cancer_ai_detection/main.dart';
import 'package:cancer_ai_detection/src/common_widgets/generic_list_screen.dart';
import 'package:cancer_ai_detection/src/common_widgets/swipe_to_delete_wrapper.dart';
import 'package:cancer_ai_detection/src/features/health_measurement/controller/health_measurement_provider.dart';
import 'package:cancer_ai_detection/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:intl/intl.dart';

class HealthMeasurementsScreen extends ConsumerWidget {
  const HealthMeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthMeasurementsAsyncValue = ref.watch(healthMeasurementProvider);
    return GenericListScreen<HealthMeasurementModel>(
      title: 'Health Measurements',
      asyncData: healthMeasurementsAsyncValue,
      onAddPressed: () => context.goNamed(AppRoute.addHealthMeasurement.name),
      itemBuilder: (context, measurement) {
        return SwipeToDeleteWrapper(
          itemKey: ValueKey(measurement.id),
          child: Card(
            child: ListTile(
              title: Text(measurement.name.name),
              subtitle: Text(measurement.value.toString()),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat(' d/M/y').format(
                      measurement.measuredAt,
                    ),
                  ),
                  8.heightBox,
                ],
              ),
            ),
          ),
          onConfirmDelete: () async {
            try {
              await client.healthMeasurement.delete(measurement.id!);
              ref.invalidate(healthMeasurementProvider);
              return true;
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return false;
            }
          },
        );
      },
    );
  }
}
