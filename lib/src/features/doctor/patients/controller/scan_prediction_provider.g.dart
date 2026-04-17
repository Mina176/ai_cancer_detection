// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_prediction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scanPrediction)
final scanPredictionProvider = ScanPredictionFamily._();

final class ScanPredictionProvider
    extends
        $FunctionalProvider<
          AsyncValue<ScanPredictionModel?>,
          ScanPredictionModel?,
          FutureOr<ScanPredictionModel?>
        >
    with
        $FutureModifier<ScanPredictionModel?>,
        $FutureProvider<ScanPredictionModel?> {
  ScanPredictionProvider._({
    required ScanPredictionFamily super.from,
    required UuidValue super.argument,
  }) : super(
         retry: null,
         name: r'scanPredictionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scanPredictionHash();

  @override
  String toString() {
    return r'scanPredictionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ScanPredictionModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ScanPredictionModel?> create(Ref ref) {
    final argument = this.argument as UuidValue;
    return scanPrediction(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ScanPredictionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scanPredictionHash() => r'886953d27d233d12af4e80e2dd171264d37cdb0f';

final class ScanPredictionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ScanPredictionModel?>, UuidValue> {
  ScanPredictionFamily._()
    : super(
        retry: null,
        name: r'scanPredictionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ScanPredictionProvider call(UuidValue scanId) =>
      ScanPredictionProvider._(argument: scanId, from: this);

  @override
  String toString() => r'scanPredictionProvider';
}
