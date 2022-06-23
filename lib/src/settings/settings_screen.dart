import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/enums/connection_status.dart';
import '../common/environment.dart';
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
                child: SettingsWidget(snapshot),
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

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class SettingsWidget extends StatelessWidget {
  final AsyncSnapshot<dynamic> settingsData;
  const SettingsWidget(this.settingsData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (settingsData.hasError) {
      var settings = ['Pull down to try again'];
      return ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return Text(settings[index]);
        },
      );
    } else if (settingsData.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      FirebaseRemoteConfig items = settingsData.data;
      Map<String, RemoteConfigValue> settings = items.getAll();
      return SettingsForm(settings);
    }
  }
}

class SettingsForm extends StatefulWidget {
  final Map<String, RemoteConfigValue> settings;
  const SettingsForm(this.settings, {Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.settings.length,
      itemBuilder: (context, index) {
        return Text('setting $index');
      },
    );
  }
}
