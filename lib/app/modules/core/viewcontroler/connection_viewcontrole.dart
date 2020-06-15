import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:go_ifsc/app/modules/core/widgets/snackbar_widget.dart';

class ConnectionController extends StatefulWidget {
  @override
  _ConnectionControllerState createState() => _ConnectionControllerState();
}

class _ConnectionControllerState extends State<ConnectionController> {
  String _connection = "";
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();

    //_connectivity.checkConnectivity().then((connectivityResult){_updateStatus(connectivityResult);});

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile) {
      setText('3G/4G');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // String wifiName = await _connectivity.getWifiName();
      // String wifiSsid = await _connectivity.getWifiBSSID();
      String wifiIp = await _connectivity.getWifiIP();
      setText('Wi-Fi: $wifiIp');
    } else {
      setText('Não Conectado!');
    }
  }

  void setText(String text) {
    setState(() {
      _connection = text;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return snackbarConnectionWidget(
      _connection,
      context,
      Colors.grey.shade300,
      5,
    );
  }
}
