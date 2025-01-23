import 'package:flutter/material.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';

// ignore: must_be_immutable
class DanielPrimaryButton extends StatefulWidget {
  Widget child;
  void Function() functionOnPressed;
  void Function() functiomOnLongPressed;

  DanielPrimaryButton(
      {super.key,
      required this.child,
      required this.functionOnPressed,
      required this.functiomOnLongPressed});

  @override
  _DanielPrimaryButtonState createState() => _DanielPrimaryButtonState();
}

class _DanielPrimaryButtonState extends State<DanielPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.functionOnPressed,
      // ignore: unnecessary_null_comparison
      onLongPress: widget.functiomOnLongPressed == null
          ? () {
              print('No long function entered');
            }
          : widget.functiomOnLongPressed,
      child: widget.child,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: DanielAcentColors.blue))),
        backgroundColor: WidgetStateProperty.all(DanielAcentColors.blue),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
        textStyle: WidgetStateProperty.all(const TextStyle(
          fontFamily: 'DanielSansLight',
          color: DanielBaseColors.white,
          fontSize: 16,
          height: 1.5,
        )),
      ),
    );
  }
}
