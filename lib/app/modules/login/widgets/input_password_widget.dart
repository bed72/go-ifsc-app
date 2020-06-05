import 'package:flutter/material.dart';

/// __TextField Password__
///
/// Parâmetros:
///
/// * __hintText__: Texto de Ajuda
/// * __typeIcon__: Icone que representara o Input
/// * __typeInput__: O tipo do determinado Input. Ex.: text, emailAddress
/// * __maxLength__: Quantidade maxíma de caracteres do Input
/// * __color__: Cor do texto interno do Input
///
class InputsPasswordWidget extends StatefulWidget {
  final String _hintText;
  final Icon _typeIcon;
  final TextInputType _typeInput;
  final int _maxLength;
  final Color _color;

  InputsPasswordWidget(
    this._hintText,
    this._typeIcon,
    this._typeInput,
    this._maxLength,
    this._color,
  );

  @override
  _InputsPasswordWidget createState() => _InputsPasswordWidget(
        this._hintText,
        this._typeIcon,
        this._typeInput,
        this._maxLength,
        this._color,
      );
}

class _InputsPasswordWidget extends State<InputsPasswordWidget> {
  final String _hintText;
  final Icon _typeIcon;
  final TextInputType _typeInput;
  final int _maxLength;
  final Color _color;

  _InputsPasswordWidget(
    this._hintText,
    this._typeIcon,
    this._typeInput,
    this._maxLength,
    this._color,
  );

  bool _passwordVisible = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

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
              suffixIcon: IconButton(
                onPressed: () {
                  _toggle();
                },
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white38, //Theme.of(context).primaryColor,
                ),
              )),
          keyboardType: this._typeInput,
          autofocus: false,
          maxLength: this._maxLength == 0 ? 64 : this._maxLength,
          maxLines: 1,
          obscureText: _passwordVisible,
          style: TextStyle(
            color: this._color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
