import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  bool _isConnected = true;
  
  bool get isConnected => _isConnected;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

  Future<bool> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    _isConnected = result != ConnectivityResult.none;
    notifyListeners();
    return _isConnected;
  }
} 