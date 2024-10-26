import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:task_tracker/tasks/core/app_colors.dart';
import 'package:task_tracker/tasks/domain/task.dart';
import 'package:task_tracker/tasks/presentation/widgets/task_card_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(56),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                backgroundColor: Colors.blue[900],
                radius: 28,
                child: Image.asset("assets/avatar.png")),
            TextButton(
              onPressed: () {},
              child: Text("+", style: context.displaySmall).bold(),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        const Gap(32),
        Text("${Jiffy.parseFromDateTime(currentDate).EEEE.toUpperCase()} ${currentDate.day}",
                style: context.labelLarge)
            .paddingSymmetric(horizontal: 16),
        const Gap(8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Text("Today".toUpperCase(), style: context.displaySmall),
              const CircleAvatar(
                backgroundColor: AppColors.secondaryBackgroundColor,
                radius: 5,
              ).paddingSymmetric(horizontal: 8),
              ...List.generate(30 - currentDate.day, (index) {
                return Text((index + currentDate.day + 1).toString(),
                        style: context.displaySmall!
                            .copyWith(color: Colors.white38))
                    .paddingSymmetric(horizontal: 8);
              }),
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
        // const Gap(0),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 4),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemBuilder: (context, index) {
              return TaskCardWidget(task: tasks[index]);
            },
          ),
        )
      ],
    ));
  }
}

final tasks = [
  Task(
      task: "Design Meeting",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.yellowAccent,
      startTime: const TimeOfDay(hour: 12, minute: 10),
      endTime: const TimeOfDay(hour: 7, minute: 20)),
  Task(
      task: "Daily Project",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.purpleAccent,
      startTime: const TimeOfDay(hour: 13, minute: 30),
      endTime: const TimeOfDay(hour: 8, minute: 40)),
  Task(
      task: "Weekly Planning",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.greenAccent,
      startTime: const TimeOfDay(hour: 2, minute: 50),
      endTime: const TimeOfDay(hour: 4, minute: 00)),
];
