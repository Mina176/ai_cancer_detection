class AppConfig {
  static const String _rawServerUrl = String.fromEnvironment(
    'SERVER_URL',
    defaultValue: 'https://gp-api.lasheen.dev/',
  );

  static String get serverUrl =>
      _rawServerUrl.endsWith('/') ? _rawServerUrl : '$_rawServerUrl/';

  static String get serverOrigin => Uri.parse(serverUrl).origin;
}
