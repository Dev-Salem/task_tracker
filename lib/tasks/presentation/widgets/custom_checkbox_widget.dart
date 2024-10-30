
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
          fillColor: const WidgetStatePropertyAll(Colors.transparent),
          checkColor: Colors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(
                strokeAlign: 1,
                width: 1.5,
                color: isDone ? Colors.lightGreen : Colors.black),
          ),
          value: isDone,
          onChanged: (z) => setState(() {
                isDone = !isDone;
              })),
    );
  }
}
