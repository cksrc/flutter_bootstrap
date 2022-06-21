import 'package:app/src/settings/settings_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../firebase_options.dart';
import 'environment.dart';

class Initializer {
  static final Initializer _singleton = Initializer._internal();
  Initializer._internal();
  static Initializer get instance => _singleton;

  Future setup() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return await setupConfig();
  }

  Future<void> setupConfig() async {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(
          seconds:
              int.parse(Environment.firebaseRemoteConfigFetchTimeoutSeconds),
        ),
        minimumFetchInterval: Duration(
          seconds: int.parse(
              Environment.firebaseRemoteConfigMinimumFetchIntervalSeconds),
        ),
      ),
    );
    await FirebaseRemoteConfig.instance.setDefaults({
      'internet_connection_check_url': Environment.internetConnectionCheckUrl,
      'API_URL': Environment.internetConnectionCheckUrl,
    });
  }
}
