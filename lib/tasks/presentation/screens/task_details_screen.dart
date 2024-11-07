import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker/tasks/core/app_colors.dart';
import 'package:task_tracker/tasks/data/task_repository.dart';
import 'package:task_tracker/tasks/presentation/widgets/custom_floating_action_button.dart';
import 'package:task_tracker/tasks/presentation/widgets/screen_details_appbar.dart';
import 'package:task_tracker/tasks/presentation/widgets/task_details_body.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  final String taskId;
  final Color backgroundColor;
  const TaskDetailsScreen(
      {super.key, required this.taskId, required this.backgroundColor});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends ConsumerState<TaskDetailsScreen>
    with SingleTickerProviderStateMixin {
  Color _backGroundColor = AppColors.backgroundColor;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    Future.delayed(0.ms, () {
      setState(() {
        _backGroundColor = widget.backgroundColor;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColorAnimation = 600.ms;
    const animationCurve = Curves.decelerate;
    return AnimatedContainer(
        duration: backgroundColorAnimation,
        color: _backGroundColor,
        curve: animationCurve,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          floatingActionButton:
              CustomFloatingActionButton(ref: ref, taskId: widget.taskId),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: DefaultTextStyle.merge(
              style: const TextStyle(color: Colors.black),
              child: SafeArea(
                  bottom: false,
                  child: ref.watch(taskProvider.call(widget.taskId)).when(
                        loading: () => const SizedBox.shrink(),
                        data: (task) {
                          return Column(
                            children: [
                              ScreenDetailsAppBar(subtasks: task.subtasks),
                              const Gap(32),
                              TaskDetailsBody(
                                taskId: task.id,
                                subtasks: task.subtasks,
                              ),
                            ],
                          );
                        },
                        error: (e, _) => Scaffold(
                          body: Text("Something Went Wrong $e").toCenter(),
                        ),
                      ))),
        ));
  }
}
