import 'package:app/src/commons/initializer.dart';
import 'package:app/src/settings/settings.provider.dart';
import 'package:app/src/settings/settings.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'commons/utils.dart';

/// The Widget that configures your application.
class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => SettingsProvider(SettingsService()),
      ),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsProvider sc = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      home: FutureBuilder(
        future: Initializer.instance.setup(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Column(children: const [Text('Settings')]),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Column(
                    children: const [
                      Text('initializing...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
