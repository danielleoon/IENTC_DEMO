import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';

// ignore: must_be_immutable
class DanielTextFieldIcon extends StatefulWidget {
  String textLabel;
  int maxLines;
  int maxLenght;
  bool enabled;
  bool readOnly;
  bool obscuredText;
  double height;
  dynamic pressed;
  TextInputType keyboardType;
  TextEditingController controller;

  DanielTextFieldIcon(
      {super.key,
      this.textLabel = '',
      this.maxLenght = 8,
      this.maxLines = 1,
      this.enabled = true,
      this.readOnly = false,
      this.obscuredText = false,
      this.height = 50.0,
      required this.pressed,
      required this.keyboardType,
      required this.controller});

  @override
  _DanielTextFieldIconState createState() => _DanielTextFieldIconState();
}

class _DanielTextFieldIconState extends State<DanielTextFieldIcon> {
  final Color _hoveredFillColor = Colors.transparent;
  final FocusNode _textFieldFocus = FocusNode();

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {});
      } else {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tema actual
    final themeData = Theme.of(context);

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          TextField(
            onTap: widget.pressed,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            readOnly: widget.readOnly,
            style: TextStyle(
              color: themeData.primaryColorDark,
              fontFamily: 'Daniel-Light',
              fontSize: 18,
              height: 1,
            ),
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLenght,
            obscureText: widget.obscuredText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(5, 10, 16, 6),
              fillColor: Colors.transparent,
              filled: false,
              hoverColor: _hoveredFillColor,
              labelText: widget.textLabel,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: themeData.primaryColorDark,
                fontFamily: 'Daniel-Light',
                fontSize: 15,
                height: 1,
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DanielColors.gray70,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              counter: const Offstage(),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      tooltip: 'Borrar',
                      icon: Icon(
                        Icons.cancel,
                        size: 18,
                        color: themeData.primaryColorDark,
                      ),
                      onPressed: widget.pressed,
                    ),
                  ],
                ),
              ),
            ),
            focusNode: _textFieldFocus,
          ),
        ],
      ),
    );
  }
}
