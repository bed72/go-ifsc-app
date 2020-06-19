import 'package:flutter/material.dart';

class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();

  final _scaffkey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get getScaffkey => _scaffkey;

  void showSnachbar(SnackBar snackbar) {
    _scaffkey.currentState.showSnackBar(snackbar);
  }
}
