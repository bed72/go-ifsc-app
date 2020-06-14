import 'package:flutter/material.dart';

/// __TextField Text__
///
/// Parâmetros:
///
/// * __hintText__: Texto de Ajuda
/// * __labelText__: Texto do campo
/// * __typeIcon__: Icone que representara o Input
/// * __typeInput__: O tipo do determinado Input. Ex.: text, emailAddress
/// * __maxLength__: Quantidade maxíma de caracteres do Input
/// * __color__: Cor do texto interno do Input
/// * __obscure__: Se e campo de senha?
/// * __bloc__ bloc responsavel pelo controle do mesmo
///
class InputTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Icon typeIcon;
  final TextInputType typeInput;
  final int maxLength;
  final Color color;
  final bool obscure;
  final bloc;
  final String Function() errorText;

  InputTextField({
    @required this.hintText,
    @required this.labelText,
    @required this.typeIcon,
    @required this.typeInput,
    @required this.maxLength,
    @required this.color,
    this.obscure,
    @required this.bloc,
    @required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38, width: 2.0),
        ),
        hintText: '$hintText',
        labelText: '$labelText',
        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white38),
        labelStyle: TextStyle(color: Colors.white38),
        prefixIcon: typeIcon,
        errorText: errorText == null ? null : errorText(),
      ),
      keyboardType: typeInput,
      autofocus: false,
      maxLength: maxLength == null ? 64 : maxLength,
      maxLines: 1,
      obscureText: obscure == null ? false : obscure,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      onChanged: bloc,
    );
  }
}
