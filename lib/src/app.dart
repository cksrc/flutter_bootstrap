import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'common/screens/error_screen.dart';
import 'common/singletons/initializer.dart';
import 'authentication/login_screen.dart';
import 'settings/settings_provider.dart';
import 'settings/settings_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => BootWidget(),
      },
    );
  }
}

class BootWidget extends StatelessWidget {
  BootWidget({Key? key}) : super(key: key);
  final List<SingleChildWidget> globalProviders = [
    ChangeNotifierProvider(create: (_) => SettingsProvider()),
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Initializer.instance.setup(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          // App initialization failed, hide splash screen and show an error
          // page
          FlutterNativeSplash.remove();
          return ErrorScreen(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          //Native Splash Screen should be shown
          return const CircularProgressIndicator();
        } else {
          // Done with the setup, hide the native splash screen
          FlutterNativeSplash.remove();
          return MultiProvider(
            providers: globalProviders,
            child: const HomeWidget(),
          );
        }
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return ErrorScreen(snapshot.error.toString());
        } else if (snapshot.hasData) {
          // User object is returned
          return const SettingsScreen();
        } else {
          // No User returned, send to Login
          return const LoginScreen();
        }
      },
    );
  }
}
