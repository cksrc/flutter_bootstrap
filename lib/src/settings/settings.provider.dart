import 'package:app/src/commons/environment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'settings.service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsProvider with ChangeNotifier {
  SettingsProvider(this._settingsService);
  final SettingsService _settingsService;

  var remoteConfigLoaded = false;

  Future<void> loadSettings() async {
    // If remoteConfig settings have not be synced and we have internet,
    // else if remoteConfig is not synched but we do not have internet, keep trying
    // else if remoteConfig already fetched return the settings

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(
          seconds:
              int.parse(Environment.firebaseRemoteConfigFetchTimeoutSeconds)),
      minimumFetchInterval: Duration(
          seconds: int.parse(
              Environment.firebaseRemoteConfigMinimumFetchIntervalSeconds)),
    ));
    notifyListeners();
  }
}
