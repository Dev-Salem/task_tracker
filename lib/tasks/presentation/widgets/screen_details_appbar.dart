import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task_tracker/tasks/domain/subtask.dart';

class ScreenDetailsAppBar extends StatelessWidget {
  final List<Subtask> subtasks;
  const ScreenDetailsAppBar({
    super.key,
    required this.subtasks,
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
                begin: 0.5,
                end: 0,
                delay: 500.ms,
                duration: 900.ms,
                curve: Curves.fastOutSlowIn)
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
            begin: 0,
            end: 1,
            duration: 600.ms,
            delay: 400.ms,
            curve: Curves.fastOutSlowIn),
      ],
    );
  }
}
