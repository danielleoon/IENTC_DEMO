import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';

// ignore: must_be_immutable
class DanielTextField extends StatefulWidget {
  String textLabel;
  int maxLines;
  int maxLength;
  bool enabled;
  bool readOnly;
  bool obscuredText;
  double height;
  TextInputType keyboardType;
  TextEditingController controller;

  DanielTextField(
      {super.key,
      this.textLabel = '',
      this.maxLength = 200,
      this.maxLines = 1,
      this.enabled = true,
      this.obscuredText = false,
      required this.height,
      required this.keyboardType,
      this.readOnly = false,
      required this.controller});

  @override
  _DanielTextFieldState createState() => _DanielTextFieldState();
}

class _DanielTextFieldState extends State<DanielTextField> {
  final Color _defaultFillColor = Colors.transparent;
  final Color _hoveredFillColor = Colors.transparent;
  final Color _focusedFillColor = Colors.transparent;
  final FocusNode _textFieldFocus = FocusNode();
  Color _color = Colors.transparent;

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = _focusedFillColor;
        });
      } else {
        setState(() {
          _color = _defaultFillColor;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        keyboardType: widget.keyboardType,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Daniel-Light',
          fontSize: 18,
          height: 1,
        ),
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        obscureText: widget.obscuredText,
        textAlign: TextAlign.left,
        maxLengthEnforcement: MaxLengthEnforcement.none,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          fillColor: _color,
          filled: true,
          hoverColor: _hoveredFillColor,
          labelText: widget.textLabel,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            color: widget.enabled ? Colors.black : Colors.black,
            fontFamily: 'Refac-Semibold',
            fontSize: 15,
            height: 1,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          counter: const Offstage(),
        ),
        focusNode: _textFieldFocus,
        cursorColor: DanielAcentColors.blue,
        enableInteractiveSelection: true,
        scrollPhysics: const ClampingScrollPhysics(),
      ),
    );
  }
}
