import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:task_tracker/tasks/core/app_colors.dart';

class TasksScreenCalendar extends StatelessWidget {
  final Duration animationExecutionTime;
  final Duration animationDelayTime;
  final Curve animationCurve;
  const TasksScreenCalendar({
    super.key,
    required this.animationExecutionTime,
    required this.animationDelayTime,
    required this.animationCurve,
  });
  int remainingDaysInMonth(DateTime date) {
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    return lastDayOfMonth.difference(date).inDays;
  }

  String getDayName(DateTime date) {
    final dayNumber = date.day;
    List<String> days = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];
    return days[dayNumber - 1].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(getDayName((currentDate)), style: context.labelLarge)
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
              Text("TODAY", style: context.displaySmall),
              const CircleAvatar(
                backgroundColor: AppColors.secondaryBackgroundColor,
                radius: 5,
              ).paddingSymmetric(horizontal: 8),
              ...List.generate(remainingDaysInMonth(currentDate), (index) {
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
      ],
    );
  }
}
