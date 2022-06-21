import 'dart:io';
import 'dart:async';
import 'package:app/src/common/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../enums/connection_status.dart';

class Utils {
  static final Utils _singleton = Utils._internal();
  Utils._internal();
  static Utils get instance => _singleton;
  ConnectionStatus previousConnectionStatus = ConnectionStatus.unset;

  Future<bool> _isInternetAvailable() async {
    try {
      await http.get(Uri.parse(Environment.internetConnectionCheckUrl)).timeout(
          Duration(
              seconds: int.parse(Environment.internetCheckTimeoutSeconds)));
      // rest of the code
      return true;
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Returns a `ConnectionStatus` Future object that denotes the application
  /// connectivity status.
  /// It is called every time there is some change in the network connectivity
  /// status as detected by
  /// [connectivity_plus](https://pub.dev/packages/connectivity_plus).
  Future<ConnectionStatus> updateConnectionStatus() async {
    ConnectionStatus returnedConnectionStatus = ConnectionStatus.unset;

    // If previously we were offline and we can access internet,
    // return `ConnectionStatus.backOnline`.
    if (previousConnectionStatus == ConnectionStatus.offline) {
      bool isConnected = await _isInternetAvailable();
      if (isConnected) {
        returnedConnectionStatus = ConnectionStatus.backOnline;
        previousConnectionStatus = ConnectionStatus.online;
      }
    }
    // If previously we were online and we cannot access internet,
    // return `ConnectionStatus.lostConnection`.
    else if (previousConnectionStatus == ConnectionStatus.online) {
      bool isConnected = await _isInternetAvailable();
      if (!isConnected) {
        returnedConnectionStatus = ConnectionStatus.lostConnection;
        previousConnectionStatus = ConnectionStatus.offline;
      }
    }
    // Else if we do not have previous connection status; check if we are offline
    else if (previousConnectionStatus == ConnectionStatus.unset) {
      bool isConnected = await _isInternetAvailable();
      if (!isConnected) {
        returnedConnectionStatus = ConnectionStatus.offline;
        previousConnectionStatus = ConnectionStatus.offline;
      } else {
        returnedConnectionStatus = ConnectionStatus.online;
        previousConnectionStatus = ConnectionStatus.online;
      }
    }
    return returnedConnectionStatus;
  }

  void showInternetConnectivitySnackBar(
      ConnectionStatus connectionStatus, BuildContext context) {
    switch (connectionStatus) {
      case ConnectionStatus.lostConnection:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connection lost!'),
          ),
        );
        break;
      case ConnectionStatus.backOnline:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are back online!'),
          ),
        );
        break;
      case ConnectionStatus.offline:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are offline!'),
          ),
        );
        break;
      default:
    }
  }
}
