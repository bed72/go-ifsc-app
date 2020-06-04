import 'package:flutter/material.dart';

/// __TextField__
///
/// Parâmetros:
///
/// * __hintText__: Texto de Ajuda
/// * __typeIcon__: Icone que representara o Input
/// * __typeInput__: O tipo do determinado Input. Ex.: text, emailAddress
/// * __maxLength__: Quantidade maxíma de caracteres do Input
/// * __obscureText__: Campo de senha  Bool: true ativa, por padrão false
/// * __color__: Cor do texto interno do Input
///
class InputsWidget extends StatefulWidget {
  final String hintText;
  final Icon typeIcon;
  final TextInputType typeInput;
  final int maxLength;
  final bool obscureText;
  final Color color;

  const InputsWidget(
    this.hintText,
    this.typeIcon,
    this.typeInput,
    this.maxLength,
    this.obscureText,
    this.color,
  );

  @override
  _InputsWidgetState createState() => _InputsWidgetState(
        this.hintText,
        this.typeIcon,
        this.typeInput,
        this.maxLength,
        this.obscureText,
        this.color,
      );
}

class _InputsWidgetState extends State<InputsWidget> {
  final String hintText;
  final Icon typeIcon;
  final TextInputType typeInput;
  final int maxLength;
  final bool obscureText;
  final Color color;

  _InputsWidgetState(
    this.hintText,
    this.typeIcon,
    this.typeInput,
    this.maxLength,
    this.obscureText,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white38, width: 2.0),
            ),
            hintText: '${this.hintText}',
            prefixIcon: this.typeIcon,
            errorText: null,
          ),
          keyboardType: this.typeInput,
          autofocus: false,
          maxLength: this.maxLength == 0 ? 64 : this.maxLength,
          maxLines: 1,
          obscureText: this.obscureText,
          style: TextStyle(
            color: this.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
