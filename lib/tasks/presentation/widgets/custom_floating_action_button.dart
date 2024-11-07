// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:task_tracker/tasks/data/task_repository.dart';
import 'package:task_tracker/tasks/presentation/controllers/tasks_controller.dart';
import 'package:task_tracker/tasks/presentation/widgets/create_task_widget.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Duration animationDuration;
  final Duration animationDelay;
  final Curve animationCurve;
  final WidgetRef ref;
  final String taskId;
  const CustomFloatingActionButton({
    super.key,
    required this.animationDuration,
    required this.animationDelay,
    required this.animationCurve,
    required this.ref,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        "Create new subtask".toUpperCase(),
        style: context.titleMedium,
      ).bold().paddingAll(16),
      icon: const Icon(Icons.add),
      iconAlignment: IconAlignment.end,
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black),
          iconSize: WidgetStatePropertyAll(24)),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            showDragHandle: true,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) => CreateTaskBottomSheet(
                  isTask: false,
                  onSaveSubtask: (selectedColor, text) {
                    ref
                        .read(tasksAsyncProvider.notifier)
                        .addSubTask(taskId, text, selectedColor);
                    context.pop();
                    ref.invalidate(taskProvider.call(taskId));
                  },
                ).paddingOnly(
                    bottom: MediaQuery.of(context).viewInsets.bottom));
      },
    ).animate(delay: animationDelay).slideY(
          //1000.ms, 900.ms,  Curves.fastOutSlowIn
          begin: 3,
          end: 0,
          duration: animationDuration,
          curve: animationCurve,
        );
  }
}
