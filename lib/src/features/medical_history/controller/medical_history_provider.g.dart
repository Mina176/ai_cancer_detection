// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MedicalHistory)
@JsonPersist()
final medicalHistoryProvider = MedicalHistoryProvider._();

@JsonPersist()
final class MedicalHistoryProvider
    extends $AsyncNotifierProvider<MedicalHistory, List<MedicalHistoryModel>> {
  MedicalHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicalHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicalHistoryHash();

  @$internal
  @override
  MedicalHistory create() => MedicalHistory();
}

String _$medicalHistoryHash() => r'fd55003aa3559376b3f3bab098b9fcf007e5fa10';

@JsonPersist()
abstract class _$MedicalHistoryBase
    extends $AsyncNotifier<List<MedicalHistoryModel>> {
  FutureOr<List<MedicalHistoryModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<MedicalHistoryModel>>,
              List<MedicalHistoryModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MedicalHistoryModel>>,
                List<MedicalHistoryModel>
              >,
              AsyncValue<List<MedicalHistoryModel>>,
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
abstract class _$MedicalHistory extends _$MedicalHistoryBase {
  /// The default key used by [persist].
  String get key {
    const resolvedKey = "MedicalHistory";
    return resolvedKey;
  }

  /// A variant of [persist], for JSON-specific encoding.
  ///
  /// You can override [key] to customize the key used for storage.
  PersistResult persist(
    FutureOr<Storage<String, String>> storage, {
    String? key,
    String Function(List<MedicalHistoryModel> state)? encode,
    List<MedicalHistoryModel> Function(String encoded)? decode,
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
                  (e) =>
                      MedicalHistoryModel.fromJson(e as Map<String, Object?>),
                )
                .toList();
          },
      options: options,
    );
  }
}
