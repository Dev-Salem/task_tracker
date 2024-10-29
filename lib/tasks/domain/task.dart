import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/tasks/domain/subtask.dart';

class Task extends Equatable {
  final String task;
  final DateTime date;
  final bool isDone;
  final Color cardColor;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<Subtask> subtasks;
  const Task({
    required this.task,
    required this.date,
    required this.isDone,
    required this.cardColor,
    required this.startTime,
    required this.endTime,
    required this.subtasks,
  });

  @override
  List<Object> get props {
    return [
      task,
      date,
      cardColor,
      startTime,
      endTime,
      isDone,
    ];
  }
}
