import 'package:flutter/material.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';

// ignore: must_be_immutable
class DanielSecondaryButton extends StatefulWidget {
  Widget child;
  void Function() functionOnPressed;
  void Function() functiomOnLongPressed;

  DanielSecondaryButton(
      {super.key,
      required this.child,
      required this.functionOnPressed,
      required this.functiomOnLongPressed});

  @override
  _DanielSecondaryButtonState createState() => _DanielSecondaryButtonState();
}

class _DanielSecondaryButtonState extends State<DanielSecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: ElevatedButton(
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
                  side: const BorderSide(
                      color: DanielAcentColors.blue, width: 2))),
          backgroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
        ),
      ),
    );
  }
}
