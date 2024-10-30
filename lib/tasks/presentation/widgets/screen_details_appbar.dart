import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
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
    final unfinishedSubtaskCount = subtasks.where((x) => !x.isDone).length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              context.pop();
            },
            color: Colors.black,
            iconSize: 32,
            icon: const Icon(
              Icons.arrow_back,
            )),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(30)),
          child: Text("$finishedSubtaskCount / $unfinishedSubtaskCount")
              .bold()
              .paddingSymmetric(horizontal: 24, vertical: 6),
        ),
      ],
    );
  }
}
