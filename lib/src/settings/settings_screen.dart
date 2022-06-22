import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/enums/connection_status.dart';
import '../common/environment.dart';
import '../common/providers/connectivity_provider.dart';
import '../common/singletons/utils.dart';
import 'settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // We use the RefreshIndicator to reload the page to force refetching settings
  // from firebase remoteConfig. '_markDirty' is a dummy parameter, only
  // to force flutter to repaint the screen.
  Future<bool> _markDirty = Future.value(true);
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      Future.delayed(
              Duration(
                seconds: int.parse(Environment.internetPreCheckTimerSeconds),
              ),
              Utils.instance.updateConnectionStatus)
          .then((connectionStatus) {
        Utils.instance
            .showInternetConnectivitySnackBar(connectionStatus, context);

        if (connectionStatus == ConnectionStatus.backOnline) {
          setState(() {
            _markDirty = Future.value(true);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future:
                settingsProvider.loadSettings(Utils.instance.connectionStatus),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return RefreshIndicator(
                onRefresh: _pullRefresh,
                child: _displaySettingsList(context, snapshot),
              );
            },
          )),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _markDirty = Future.value(_markDirty);
    });
  }

  Widget _displaySettingsList(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasError) {
      var settings = ['Pull down to try again'];
      return ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return Text(settings[index]);
        },
      );
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      FirebaseRemoteConfig items = snapshot.data;
      Map<String, RemoteConfigValue> settings = items.getAll();
      return ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return Text('setting $index');
        },
      );
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
