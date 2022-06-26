import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../../firebase_options.dart';
import '../environment.dart';

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
      'INTERNET_CONNECTION_CHECK_URL': Environment.internetConnectionCheckUrl,
      'INTERNET_PRE_CHECK_TIMER_SECONDS':
          Environment.internetPreCheckTimerSeconds,
      'INTERNET_CHECK_TIMEOUT_SECONDS': Environment.internetCheckTimeoutSeconds,
      'FIREBASE_REMOTE_CONFIG_FETCH_TIMEOUT_SECONDS':
          Environment.firebaseRemoteConfigFetchTimeoutSeconds,
      'FIREBASE_REMOTE_CONFIG_MINIMUM_FETCH_INTERVAL_SECONDS':
          Environment.firebaseRemoteConfigMinimumFetchIntervalSeconds,
      'API_URL': Environment.internetConnectionCheckUrl,
      //'USE_MOCK_DATA': Environment
    });
  }
}
