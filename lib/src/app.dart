import 'package:app/src/common/singletons/initializer.dart';
import 'package:app/src/settings/settings_provider.dart';
import 'package:app/src/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'common/screens/error_screen.dart';
import 'common/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final List<SingleChildWidget> globalProviders = [
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Initializer.instance.setup(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return MultiProvider(
              providers: globalProviders,
              child: const BootWidget(),
            );
          }
        },
      ),
    );
  }
}

class BootWidget extends StatelessWidget {
  const BootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen();
  }
}
