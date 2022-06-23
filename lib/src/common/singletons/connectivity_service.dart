import 'dart:async';
import 'package:app/src/common/singletons/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../environment.dart';

class ConnectivityService {
  static final ConnectivityService _singleton = ConnectivityService._internal();
  ConnectivityService._internal();
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
