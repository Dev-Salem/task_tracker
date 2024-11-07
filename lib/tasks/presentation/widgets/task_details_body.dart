// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:task_tracker/tasks/data/task_repository.dart';
import 'package:task_tracker/tasks/domain/subtask.dart';
import 'package:task_tracker/tasks/presentation/controllers/tasks_controller.dart';
import 'package:task_tracker/tasks/presentation/widgets/subtask_card_widget.dart';

class TaskDetailsBody extends StatelessWidget {
  final String taskId;
  final List<Subtask> subtasks;
  final Duration cardsListsAnimation;
  final Duration cardsListDelay;
  final Curve animationCurve;
  const TaskDetailsBody({
    super.key,
    required this.taskId,
    required this.subtasks,
    required this.cardsListsAnimation,
    required this.cardsListDelay,
    required this.animationCurve,
  });

  double calculateDynamicHeight(
      int index, double availableHeight, int itemCount) {
    if (index == 0) return availableHeight;
    double offset = availableHeight / (itemCount * 1.5);
    return (availableHeight - (offset * index));
  }

  double calculateDynamicTopOffset(
      int index, double availableHeight, int itemCount) {
    if (index == 0) return 0;
    return availableHeight / (itemCount * 1.5) * index;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, cons) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    "Tasks".toUpperCase(),
                    style: const TextStyle(fontSize: 96, height: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ...List.generate(subtasks.length, (index) {
              return Positioned(
                  top: 180 +
                      calculateDynamicTopOffset(
                          index, cons.maxHeight, subtasks.length),
                  height: calculateDynamicHeight(
                      index, cons.maxHeight, subtasks.length),
                  left: 0,
                  right: 0,
                  child: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      return SubtaskCardWidget(
                        index: index,
                        subtask: subtasks[index],
                        onCheck: (p0) {
                          ref
                              .read(tasksAsyncProvider.notifier)
                              .checkSubTask(taskId, subtasks[index].id);
                          ref.invalidate(taskProvider.call(taskId));
                        },
                      );
                    },
                  ));
            }),
          ].animate(interval: 200.ms, delay: cardsListDelay).slideY(
                begin: 1,
                end: 0,
                duration: cardsListsAnimation,
                curve: animationCurve,
              ),
        );
      }),
    );
  }
}
