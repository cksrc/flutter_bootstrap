import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../environment.dart';
import 'utils.dart';

class ConnectivityService {
  static final ConnectivityService _singleton =
      ConnectivityService._constructor();
  ConnectivityService._constructor();
  static ConnectivityService get instance => _singleton;
  late StreamSubscription<ConnectivityResult> _checkConnectivitySubscription;

  void monitor(BuildContext context) {
    _checkConnectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      Future.delayed(
              Duration(
                seconds: int.parse(Environment.internetPreCheckTimerSeconds),
              ),
              Utils.instance.updateConnectionStatus)
          .then((value) =>
              Utils.instance.showInternetConnectivitySnackBar(value, context));
    });
  }

  void dispose() {
    _checkConnectivitySubscription.cancel();
  }
}
