import 'package:flutter/material.dart';

/// __TextField Text__
///
/// Parâmetros:
///
/// * __hintText__: Texto de Ajuda
/// * __typeIcon__: Icone que representara o Input
/// * __typeInput__: O tipo do determinado Input. Ex.: text, emailAddress
/// * __maxLength__: Quantidade maxíma de caracteres do Input
/// * __color__: Cor do texto interno do Input
/// * __bloc__ bloc responsavel pelo controle do mesmo
///
class InputTextField extends StatelessWidget {
  final String hintText;
  final Icon typeIcon;
  final TextInputType typeInput;
  final int maxLength;
  final Color color;
  final bloc;
  final String Function() errorText;

  InputTextField({
    this.hintText,
    this.typeIcon,
    this.typeInput,
    this.maxLength,
    this.color,
    this.bloc,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    var getText = TextEditingController();

    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38, width: 2.0),
        ),
        hintText: '$hintText',
        prefixIcon: typeIcon,
        errorText: errorText == null ? null : errorText(),
      ),
      keyboardType: typeInput,
      autofocus: false,
      maxLength: maxLength == null ? 64 : maxLength,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
      ),
      controller: getText,
      onChanged: (_) {
        bloc(getText.text);
      },
    );
  }
}
