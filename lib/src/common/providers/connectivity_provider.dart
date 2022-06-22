import 'dart:async';
import 'package:app/src/common/enums/connection_status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../environment.dart';
import '../singletons/utils.dart';

class ConnectivityProvider with ChangeNotifier {
  ConnectionStatus _connectionStatus = ConnectionStatus.unset;

  late StreamSubscription<ConnectivityResult> _subscription;
  ConnectivityProvider();

  get connectionStatus {
    ConnectionStatus latestConnectionStatus = _connectionStatus;
    return latestConnectionStatus;
  }

  void addConnectivityListener(BuildContext context) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      Future.delayed(
              Duration(
                seconds: int.parse(Environment.internetPreCheckTimerSeconds),
              ),
              Utils.instance.updateConnectionStatus)
          .then((value) {
        Utils.instance
            .showInternetConnectivitySnackBar(connectionStatus, context);
        _connectionStatus = value;
        notifyListeners();
      });
    });
  }

  void removeConnectivityListener() {
    _subscription.cancel();
  }
}
