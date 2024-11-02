import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker/tasks/core/app_colors.dart';
import 'package:task_tracker/tasks/domain/task.dart';
import 'package:task_tracker/tasks/presentation/widgets/custom_toggle_button.dart';
import 'package:task_tracker/tasks/presentation/widgets/screen_details_appbar.dart';
import 'package:task_tracker/tasks/presentation/widgets/subtask_card_widget.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen>
    with SingleTickerProviderStateMixin {
  bool selectedButton = true;
  Color _backGroundColor = AppColors.backgroundColor;
  late final AnimationController _controller;

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
  void initState() {
    _controller = AnimationController(vsync: this);
    Future.delayed(0.ms, () {
      setState(() {
        _backGroundColor = widget.task.cardColor;
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
    final subtasksCount = widget.task.subtasks.length;
    return AnimatedContainer(
      duration: 400.ms,
      color: _backGroundColor,
      curve: Curves.decelerate,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DefaultTextStyle.merge(
            style: const TextStyle(color: Colors.black),
            child: Column(
              children: [
                const Gap(48),
                ScreenDetailsAppBar(subtasks: widget.task.subtasks),
                const Gap(32),
                Expanded(
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
                              CustomToggleButton(
                                  selectedButton: selectedButton,
                                  onPressed: (index) {
                                    setState(() {
                                      selectedButton = !selectedButton;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        ...List.generate(subtasksCount, (index) {
                          return Positioned(
                              top: 200 +
                                  calculateDynamicTopOffset(
                                      index, cons.maxHeight, subtasksCount),
                              height: calculateDynamicHeight(
                                  index, cons.maxHeight, subtasksCount),
                              left: 0,
                              right: 0,
                              child: SubtaskCardWidget(
                                  index: index,
                                  subtask: widget.task.subtasks[index]));
                        }),
                      ].animate(interval: 200.ms, delay: 1000.ms).slideY(
                            begin: 1,
                            end: 0,
                            duration: 900.ms,
                            curve: Curves.fastOutSlowIn,
                          ),
                    );
                  }),
                )
              ],
            )),
      ),
    );
  }
}
