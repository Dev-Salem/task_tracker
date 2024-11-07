import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker/tasks/presentation/controllers/tasks_controller.dart';
import 'package:task_tracker/tasks/presentation/widgets/task_cards_list.dart';
import 'package:task_tracker/tasks/presentation/widgets/tasks_screen_appbar.dart';
import 'package:task_tracker/tasks/presentation/widgets/tasks_screen_calendar.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animationExecutionTime = 900.ms;
    final animationDelayTime = 500.ms;
    const animationCurve = Curves.fastOutSlowIn;
    final notifier = ref.watch(tasksAsyncProvider);
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          TasksScreenAppBar(
              ref: ref,
              animationExecutionTime: animationExecutionTime,
              animationDelayTime: animationDelayTime,
              animationCurve: animationCurve),
          const Gap(32),
          TasksScreenCalendar(
              animationExecutionTime: animationExecutionTime,
              animationDelayTime: animationDelayTime,
              animationCurve: animationCurve),
          notifier.when(
              data: (tasks) {
                return TaskCardsList(
                    tasks: tasks,
                    controller: _controller,
                    animationExecutionTime: animationExecutionTime,
                    animationDelayTime: animationDelayTime,
                    animationCurve: animationCurve);
              },
              error: (e, s) => Text("Something went wrong $e"),
              loading: () => const CircularProgressIndicator.adaptive())
        ],
      )
          .animate(autoPlay: false, controller: _controller)
          .slideY(
              begin: 0, end: -1, duration: 1000.ms, curve: Curves.fastOutSlowIn)
          .fadeOut(),
    ));
  }
}
