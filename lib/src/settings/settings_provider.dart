import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../common/enums/connection_status.dart';

class SettingsProvider with ChangeNotifier {
  SettingsProvider();

  Future loadSettings(lastConnectionStatus) async {
    if (lastConnectionStatus == ConnectionStatus.online ||
        lastConnectionStatus == ConnectionStatus.backOnline) {
      await FirebaseRemoteConfig.instance.fetchAndActivate();
      return FirebaseRemoteConfig.instance;
    } else {
      return FirebaseRemoteConfig.instance;
    }
  }
}
