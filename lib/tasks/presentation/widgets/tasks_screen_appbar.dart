import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker/tasks/presentation/controllers/tasks_controller.dart';
import 'package:task_tracker/tasks/presentation/widgets/create_task_widget.dart';

class TasksScreenAppBar extends StatelessWidget {
  final WidgetRef ref;
  final Duration animationExecutionTime;
  final Duration animationDelayTime;
  final Curve animationCurve;
  const TasksScreenAppBar({
    super.key,
    required this.ref,
    required this.animationExecutionTime,
    required this.animationDelayTime,
    required this.animationCurve,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
                backgroundColor: Colors.blue[900],
                radius: 28,
                child: Image.asset("assets/avatar.png"))
            .animate()
            .scaleXY(
                begin: 0,
                end: 1,
                duration: animationExecutionTime,
                curve: animationCurve),
        const Gap(12),
        Text(
          "Hello,\nSalem 👋",
          style: context.titleLarge!.copyWith(height: 1.0),
        ).bold().animate().scaleXY(
            begin: 0,
            end: 1,
            duration: animationExecutionTime,
            delay: animationDelayTime * 1.5,
            curve: animationCurve),
        const Expanded(child: SizedBox()),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) => CreateTaskBottomSheet(
                      isTask: true,
                      onSaveTask: (selectedColor, text, from, to) async {
                        await ref
                            .read(tasksAsyncProvider.notifier)
                            .addTask(text, from, to, selectedColor);
                        context.pop();
                      },
                    ).paddingOnly(
                        bottom: MediaQuery.of(context).viewInsets.bottom));
          },
          child: Text("+", style: context.displaySmall).bold(),
        )
            .animate()
            .rotate(
                begin: 0.5,
                end: 0,
                delay: animationDelayTime * 2,
                duration: animationExecutionTime,
                curve: animationCurve)
            .scaleXY(begin: 0, end: 1),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
