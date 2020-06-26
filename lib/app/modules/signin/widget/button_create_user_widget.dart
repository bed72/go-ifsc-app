import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class ButtonAccount extends StatelessWidget {
  final bloc;
  final snapshot;

  const ButtonAccount({
    Key key,
    @required this.bloc,
    @required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => {
        //print('${this.snapshot}'),
        this.bloc.fetchCreateAccount(),
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          27,
        ),
      ),
      child: Container(
        width: 360,
        height: 60,
        alignment: Alignment.center,
        child: Text(
          'Create Account',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
