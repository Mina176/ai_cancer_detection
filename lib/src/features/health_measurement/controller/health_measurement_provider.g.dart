// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_measurement_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HealthMeasurement)
@JsonPersist()
final healthMeasurementProvider = HealthMeasurementProvider._();

@JsonPersist()
final class HealthMeasurementProvider
    extends
        $AsyncNotifierProvider<
          HealthMeasurement,
          List<HealthMeasurementModel>
        > {
  HealthMeasurementProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthMeasurementProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthMeasurementHash();

  @$internal
  @override
  HealthMeasurement create() => HealthMeasurement();
}

String _$healthMeasurementHash() => r'8cd72d0e309b069f227a6ec717274e4098cb28f9';

@JsonPersist()
abstract class _$HealthMeasurementBase
    extends $AsyncNotifier<List<HealthMeasurementModel>> {
  FutureOr<List<HealthMeasurementModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<HealthMeasurementModel>>,
              List<HealthMeasurementModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<HealthMeasurementModel>>,
                List<HealthMeasurementModel>
              >,
              AsyncValue<List<HealthMeasurementModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// **************************************************************************
// JsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
abstract class _$HealthMeasurement extends _$HealthMeasurementBase {
  /// The default key used by [persist].
  String get key {
    const resolvedKey = "HealthMeasurement";
    return resolvedKey;
  }

  /// A variant of [persist], for JSON-specific encoding.
  ///
  /// You can override [key] to customize the key used for storage.
  PersistResult persist(
    FutureOr<Storage<String, String>> storage, {
    String? key,
    String Function(List<HealthMeasurementModel> state)? encode,
    List<HealthMeasurementModel> Function(String encoded)? decode,
    StorageOptions options = const StorageOptions(),
  }) {
    return NotifierPersistX(this).persist<String, String>(
      storage,
      key: key ?? this.key,
      encode: encode ?? $jsonCodex.encode,
      decode:
          decode ??
          (encoded) {
            final e = $jsonCodex.decode(encoded);
            return (e as List)
                .map(
                  (e) => HealthMeasurementModel.fromJson(
                    e as Map<String, Object?>,
                  ),
                )
                .toList();
          },
      options: options,
    );
  }
}
