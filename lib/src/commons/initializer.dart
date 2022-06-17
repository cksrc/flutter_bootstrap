import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

class Initializer {
  static final Initializer _singleton = Initializer._internal();
  Initializer._internal();
  static Initializer get instance => _singleton;

  Future setup() async {
    return await Future.wait([_setupExternalServices()]);
  }

  Future _setupExternalServices() {
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
