import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:task_tracker/tasks/domain/task.dart';

class TaskCardWidget extends StatelessWidget {
  final Task task;
  const TaskCardWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
          color: task.cardColor, borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(24),
          CustomClockWidget(start: task.startTime, end: task.endTime),
          const Gap(24),
          Expanded(
            child: AutoSizeText(
              task.task.toUpperCase(),
              style: context.displayLarge!.copyWith(color: Colors.black),
              softWrap: false,
              maxLines: 3,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ).animate().fadeIn(
                duration: 800.ms, delay: 300.ms, curve: Curves.easeInOutQuad),
          ),
          const Gap(12),
        ],
      ),
    );
  }
}

class CustomClockWidget extends StatelessWidget {
  final TimeOfDay start;
  final TimeOfDay end;
  const CustomClockWidget({
    super.key,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(color: Colors.black),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            start.hour.toString(),
            style: const TextStyle(fontSize: 20),
            // style: context.titleMedium,
          ).bold(),
          Text(
            start.minute.toString(),
          ),
          Container(height: 20, width: 1, color: Colors.black),
          Text(
            end.hour.toString(),
            style: const TextStyle(fontSize: 20),
            // style: context.titleMedium,
          ).bold(),
          Text(
            end.minute.toString(),
          ),
        ].animate(interval: 100.ms).fadeIn(
            // begin: 0,
            // end: 1,
            duration: 800.ms,
            delay: 200.ms,
            curve: Curves.easeInOutQuad),
      ),
    );
  }
}
