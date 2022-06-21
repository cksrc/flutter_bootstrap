import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Used for converting the .env.* files in a format accessible by the dot
/// notation and is accessible from the IDE's autocompletion.
class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get apiUrl => dotenv.env['API_URL'] ?? 'http://localhost';
  static String get internetConnectionCheckUrl =>
      dotenv.env['INTERNET_CONNECTION_CHECK_URL'] ?? 'https://google.com';
  static String get firebaseRemoteConfigFetchTimeoutSeconds =>
      dotenv.env['FIREBASE_REMOTE_CONFIG_FETCH_TIMEOUT_SECONDS'] ?? '20';
  static String get internetCheckTimeoutSeconds =>
      dotenv.env['INTERNET_CHECK_TIMEOUT_SECONDS'] ?? '10';
  static String get internetPreCheckTimerSeconds =>
      dotenv.env['INTERNET_PRE_CHECK_TIMER_SECONDS'] ?? '4';
  static String get firebaseRemoteConfigMinimumFetchIntervalSeconds =>
      dotenv.env['FIREBASE_REMOTE_CONFIG_MINIMUM_FETCH_INTERVAL_SECONDS'] ??
      '1';
}
