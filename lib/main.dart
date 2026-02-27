import 'package:cancer_ai_detection/features/upload_image/presentation/upload_screen_desktop.dart';
import 'package:cancer_ai_detection/theming/app_theme.dart';
import 'package:cancer_ai_detection/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gp_backend_client/gp_backend_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late Client client;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const serverUrl = 'https://gp-api.lasheen.dev/';
  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  try {
    await client.auth.initialize();
  } catch (e) {
    print('Failed to initialize Serverpod auth: $e');
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
