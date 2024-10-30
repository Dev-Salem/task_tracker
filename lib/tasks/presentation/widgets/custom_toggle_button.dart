import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  final bool selectedButton;
  final Function(int)? onPressed;
  const CustomToggleButton({
    super.key,
    required this.selectedButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      // widthFactor: 2.2,
      child: ToggleButtons(
          isSelected: [selectedButton, !selectedButton],
          renderBorder: false,
          onPressed: onPressed,
          color: Colors.black26,
          fillColor: Colors.transparent,
          selectedColor: Colors.black,
          children: [
            Text("Active".toUpperCase()).paddingSymmetric(horizontal: 15),
            Text("Done".toUpperCase()).paddingSymmetric(horizontal: 15),
          ]),
    );
  }
}
