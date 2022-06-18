import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get apiUrl => dotenv.env['API_URL'] ?? 'http://localhost';
  static String get internetConnectionCheckUrl =>
      dotenv.env['INTERNET_CONNECTION_CHECK_URL'] ?? 'https://google.com';
  static String get firebaseRemoteConfigFetchTimeoutSeconds =>
      dotenv.env['FIREBASE_REMOTE_CONFIG_FETCH_TIMEOUT_SECONDS'] ?? '20';
  static String get firebaseRemoteConfigMinimumFetchIntervalSeconds =>
      dotenv.env['FIREBASE_REMOTE_CONFIG_MINIMUM_FETCH_INTERVAL_SECONDS'] ??
      '1';
}
