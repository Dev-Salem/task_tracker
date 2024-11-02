import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_tracker/tasks/core/app_colors.dart';
import 'package:task_tracker/tasks/domain/subtask.dart';
import 'package:task_tracker/tasks/domain/task.dart';
import 'package:task_tracker/tasks/presentation/widgets/task_card_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
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
    final currentDate = DateTime.now();
    final animationExecutionTime = 900.ms;
    final animationDelayTime = 500.ms;
    const animationCurve = Curves.fastOutSlowIn;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(56),
        Row(
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
              onPressed: () {},
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
        ).paddingSymmetric(horizontal: 16),
        const Gap(32),
        Text("${Jiffy.parseFromDateTime(currentDate).EEEE.toUpperCase()} ${currentDate.day}",
                style: context.labelLarge)
            .paddingSymmetric(horizontal: 16)
            .animate()
            .scaleXY(
                begin: 0,
                end: 1,
                duration: animationExecutionTime,
                delay: animationDelayTime * 3,
                curve: animationCurve),
        const Gap(8),
        SizedBox(
          height: 40,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              Text("Today".toUpperCase(), style: context.displaySmall),
              const CircleAvatar(
                backgroundColor: AppColors.secondaryBackgroundColor,
                radius: 5,
              ).paddingSymmetric(horizontal: 8),
              ...List.generate(31 - currentDate.day, (index) {
                return Text((index + currentDate.day + 1).toString(),
                        style: context.displaySmall!
                            .copyWith(color: Colors.white38))
                    .paddingSymmetric(horizontal: 8);
              }),
            ],
          ),
        ).paddingSymmetric(horizontal: 16).animate().slideX(
            begin: 1,
            end: 0,
            duration: animationExecutionTime,
            curve: animationCurve,
            delay: animationDelayTime * 4),
        // const Gap(0),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 4),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    _controller.addStatusListener((status) {
                      if (status.isCompleted) {
                        Navigator.of(context)
                            .pushNamed('task_details', arguments: tasks[index]);
                      }
                    });
                    _controller.forward();
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
        )
      ],
    )
            .animate(autoPlay: false, controller: _controller)
            .slideY(
                begin: 0,
                end: -1,
                duration: 1000.ms,
                curve: Curves.fastOutSlowIn)
            .fadeOut());
  }
}

final tasks = [
  Task(
      task: "Design Meeting",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.yellowAccent,
      startTime: const TimeOfDay(hour: 12, minute: 10),
      endTime: const TimeOfDay(hour: 7, minute: 20),
      subtasks: [
        Subtask(
            name: "Set up a video conference 4",
            isDone: false,
            cardColor: Colors.amberAccent),
        Subtask(
            name: "Prepare the meeting room 3",
            isDone: true,
            cardColor: Colors.orangeAccent),
        Subtask(
            name: "Work on the backend 2",
            isDone: false,
            cardColor: Colors.teal),
        Subtask(
            name: "Work on the frontend 2",
            isDone: false,
            cardColor: Colors.indigo),
        Subtask(
            name: "Set up a video conference 1",
            isDone: false,
            cardColor: Colors.amberAccent),
        Subtask(
            name: "Prepare the meeting room 1",
            isDone: true,
            cardColor: Colors.orangeAccent),
        Subtask(
            name: "Work on the backend 1",
            isDone: false,
            cardColor: Colors.teal),
        Subtask(
            name: "Work on the frontend 1",
            isDone: false,
            cardColor: Colors.indigo),
      ]),
  Task(
      task: "Daily Project",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.purpleAccent,
      startTime: const TimeOfDay(hour: 13, minute: 30),
      endTime: const TimeOfDay(hour: 8, minute: 40),
      subtasks: [
        Subtask(
            name: "Set up a video conference",
            isDone: false,
            cardColor: Colors.amberAccent),
        Subtask(
            name: "Prepare the meeting room",
            isDone: true,
            cardColor: Colors.orangeAccent),
        Subtask(
            name: "Work on the backend", isDone: false, cardColor: Colors.teal),
        Subtask(
            name: "Work on the frontend",
            isDone: false,
            cardColor: Colors.indigo),
      ]),
  Task(
      task: "Weekly Planning",
      date: DateTime.now(),
      isDone: false,
      subtasks: [
        Subtask(
            name: "Set up a video conference",
            isDone: false,
            cardColor: Colors.amberAccent),
        Subtask(
            name: "Prepare the meeting room",
            isDone: true,
            cardColor: Colors.orangeAccent),
        Subtask(
            name: "Work on the backend", isDone: false, cardColor: Colors.teal),
        Subtask(
            name: "Work on the frontend",
            isDone: false,
            cardColor: Colors.indigo),
      ],
      cardColor: Colors.greenAccent,
      startTime: const TimeOfDay(hour: 2, minute: 50),
      endTime: const TimeOfDay(hour: 4, minute: 00)),
  Task(
      task: "Design Meeting",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.yellowAccent,
      startTime: const TimeOfDay(hour: 12, minute: 10),
      endTime: const TimeOfDay(hour: 7, minute: 20),
      subtasks: [
        Subtask(
            name: "Set up a video conference",
            isDone: false,
            cardColor: Colors.amberAccent),
      ]),
  Task(
      task: "Daily Project",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.purpleAccent,
      startTime: const TimeOfDay(hour: 13, minute: 30),
      endTime: const TimeOfDay(hour: 8, minute: 40),
      subtasks: const []),
  Task(
      task: "Weekly Planning",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.greenAccent,
      startTime: const TimeOfDay(hour: 2, minute: 50),
      endTime: const TimeOfDay(hour: 4, minute: 00),
      subtasks: const []),
  Task(
      task: "Daily Project",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.purpleAccent,
      startTime: const TimeOfDay(hour: 13, minute: 30),
      endTime: const TimeOfDay(hour: 8, minute: 40),
      subtasks: const []),
  Task(
      task: "Weekly Planning",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.greenAccent,
      startTime: const TimeOfDay(hour: 2, minute: 50),
      endTime: const TimeOfDay(hour: 4, minute: 00),
      subtasks: const []),
  Task(
      task: "Design Meeting",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.yellowAccent,
      startTime: const TimeOfDay(hour: 12, minute: 10),
      endTime: const TimeOfDay(hour: 7, minute: 20),
      subtasks: const []),
  Task(
      task: "Daily Project",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.purpleAccent,
      startTime: const TimeOfDay(hour: 13, minute: 30),
      endTime: const TimeOfDay(hour: 8, minute: 40),
      subtasks: const []),
  Task(
      task: "Weekly Planning",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.greenAccent,
      startTime: const TimeOfDay(hour: 2, minute: 50),
      endTime: const TimeOfDay(hour: 4, minute: 00),
      subtasks: const []),
];
