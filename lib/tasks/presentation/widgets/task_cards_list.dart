import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task_tracker/tasks/domain/task.dart';
import 'package:task_tracker/tasks/presentation/widgets/task_card_widget.dart';

class TaskCardsList extends StatelessWidget {
  final List<Task> tasks;
  final AnimationController controller;
  final Duration animationExecutionTime;
  final Duration animationDelayTime;
  final Curve animationCurve;

  const TaskCardsList({
    super.key,
    required this.tasks,
    required this.controller,
    required this.animationExecutionTime,
    required this.animationDelayTime,
    required this.animationCurve,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 4),
        itemCount: tasks.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                controller.addStatusListener((status) {
                  if (status.isCompleted) {
                    Navigator.of(context).pushNamed('task_details',
                        arguments: (tasks[index].id, tasks[index].cardColor));
                  }
                });
                controller.forward();
              },
              child: TaskCardWidget(task: tasks[index]));
        },
      ).animate().slideX(
          begin: 1.1,
          end: 0,
          duration: animationExecutionTime,
          curve: animationCurve,
          // curve: Curves.easeInOutSine,
          delay: animationDelayTime * 4.5),
    );
  }
}