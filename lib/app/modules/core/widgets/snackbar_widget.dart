import 'package:flutter/material.dart';

Widget snackbarWidget(
  BuildContext context,
  dynamic snapshot,
  Color color,
  int duration,
) {
  return SnackBar(
    content: Text(
      snapshot.data == null
          ? 'Preencha os campos corretamente!'
          : '${snapshot.error}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Google',
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: color,
    duration: Duration(seconds: duration),
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
  );
}

Widget snackbarConnectionWidget(
  String text,
  BuildContext context,
  Color color,
  int duration,
) {
  return SnackBar(
    content: Text(
      '$text',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Google',
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: color,
    duration: Duration(seconds: duration),
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
    ),
  );
}
