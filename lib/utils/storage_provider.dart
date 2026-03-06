import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';

final storageProvider = FutureProvider<Storage<String, String>>((ref) async {
  return JsonSqFliteStorage.open(
    join(await getDatabasesPath(), 'med_ai_cache.db'),
  );
});
