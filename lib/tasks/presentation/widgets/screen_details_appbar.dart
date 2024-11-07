// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:task_tracker/tasks/domain/subtask.dart';

class ScreenDetailsAppBar extends StatelessWidget {
  final List<Subtask> subtasks;
  final Duration backButtonAnimation;
  final Duration backButtonDelay;
  final Duration subtasksCounterAnimation;
  final Duration subtasksCounterDelay;
  final Curve animationCurve;
  const ScreenDetailsAppBar({
    super.key,
    required this.subtasks,
    required this.backButtonAnimation,
    required this.backButtonDelay,
    required this.subtasksCounterAnimation,
    required this.subtasksCounterDelay,
    required this.animationCurve,
  });

  @override
  Widget build(BuildContext context) {
    final finishedSubtaskCount = subtasks.where((x) => x.isDone).length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
                onPressed: () {
                  context.pushReplacementNamed("tasks");
                },
                color: Colors.black,
                iconSize: 32,
                icon: const Icon(
                  Icons.arrow_back,
                ))
            .animate()
            .rotate(
                // 500.ms,
                begin: 0.5,
                end: 0,
                delay: backButtonDelay,
                duration: backButtonDelay,
                curve: animationCurve)
            .scaleXY(begin: 0, end: 1),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(30)),
          child: Text("$finishedSubtaskCount / ${subtasks.length}")
              .bold()
              .paddingSymmetric(horizontal: 24, vertical: 6),
        ).animate().scaleXY(
            // 600.ms,, 400.ms,
            begin: 0,
            end: 1,
            duration: subtasksCounterAnimation,
            delay: subtasksCounterDelay,
            curve: animationCurve),
      ],
    );
  }
}
