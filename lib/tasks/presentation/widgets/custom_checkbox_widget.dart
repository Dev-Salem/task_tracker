import 'package:flutter/material.dart';
import 'package:task_tracker/core/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final Function(bool?) onCheck;
  const CustomCheckBox({
    super.key,
    required this.isChecked,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
          fillColor: const WidgetStatePropertyAll(Colors.transparent),
          checkColor: AppColors.checkBoxColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(
                strokeAlign: 1,
                width: 1.5,
                color: isChecked ? AppColors.checkBoxColor : Colors.black),
          ),
          value: isChecked,
          onChanged: onCheck),
    );
  }
}
