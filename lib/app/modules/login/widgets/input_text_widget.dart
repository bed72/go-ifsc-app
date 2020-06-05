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
///
class InputsTextWidget extends StatefulWidget {
  final String _hintText;
  final Icon _typeIcon;
  final TextInputType _typeInput;
  final int _maxLength;
  final Color _color;

  InputsTextWidget(
    this._hintText,
    this._typeIcon,
    this._typeInput,
    this._maxLength,
    this._color,
  );

  @override
  _InputsTextWidgetState createState() => _InputsTextWidgetState(
        this._hintText,
        this._typeIcon,
        this._typeInput,
        this._maxLength,
        this._color,
      );
}

class _InputsTextWidgetState extends State<InputsTextWidget> {
  final String _hintText;
  final Icon _typeIcon;
  final TextInputType _typeInput;
  final int _maxLength;
  final Color _color;

  _InputsTextWidgetState(
    this._hintText,
    this._typeIcon,
    this._typeInput,
    this._maxLength,
    this._color,
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
            hintText: '${this._hintText}',
            prefixIcon: this._typeIcon,
            errorText: null,
          ),
          keyboardType: this._typeInput,
          autofocus: false,
          maxLength: this._maxLength == 0 ? 64 : this._maxLength,
          maxLines: 1,
          style: TextStyle(
            color: this._color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
