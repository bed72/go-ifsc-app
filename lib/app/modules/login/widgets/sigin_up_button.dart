import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(
        top: 160,
      ),
      onPressed: () {
        // push
      },
      child: Text(
        "Não possui cadastro? Cadastre-se!",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Colors.white,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// FlatButton(
//                             onPressed: () {
//                               doLogin();
//                             },
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                               side: BorderSide(color: Colors.green),
//                             ),
//                             padding: EdgeInsets.all(5.0),
//                             textColor: Colors.white,
//                             child: Text(
//                               'Signin',
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
