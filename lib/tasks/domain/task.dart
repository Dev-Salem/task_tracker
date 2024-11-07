import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:task_tracker/tasks/domain/subtask.dart';

class Task extends Equatable {
  final String id;
  final String task;
  final DateTime date;
  final bool isDone;
  final Color cardColor;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<Subtask> subtasks;
  const Task({
    required this.id,
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
    return [id, task, date, cardColor, startTime, endTime, isDone, subtasks];
  }

  Task copyWith({
    String? id,
    String? task,
    DateTime? date,
    bool? isDone,
    Color? cardColor,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<Subtask>? subtasks,
  }) {
    return Task(
      id: id ?? this.id,
      task: task ?? this.task,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      cardColor: cardColor ?? this.cardColor,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}
