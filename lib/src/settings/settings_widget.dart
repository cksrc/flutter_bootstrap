import 'package:app/src/settings/settings_form.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final AsyncSnapshot<dynamic> settingsData;
  final Future<void> Function() pullRefresh;

  const SettingsWidget(this.settingsData, this.pullRefresh, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (settingsData.hasError) {
      var settings = [];
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to load settings. Pull down to try again.')));
      return RefreshIndicator(
        onRefresh: pullRefresh,
        child: ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return Text(settings[index]);
          },
        ),
      );
    } else if (settingsData.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      FirebaseRemoteConfig items = settingsData.data;
      Map<String, RemoteConfigValue> settings = items.getAll();
      return SettingsForm(settings, pullRefresh);
    }
  }
}
