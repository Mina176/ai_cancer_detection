import 'package:cancer_ai_detection/src/theming/app_theme.dart';
import 'package:cancer_ai_detection/src/config/app_config.dart';
import 'package:cancer_ai_detection/src/routing/controller/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

late Client client;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final serverUrl = AppConfig.serverUrl;
  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  try {
    await client.auth.initialize();
  } catch (e) {
    print('Error initializing authentication: $e');
  }
  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
