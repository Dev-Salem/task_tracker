import 'package:flutter/material.dart';
import 'package:task_tracker/tasks/domain/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];
  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  Future<List<Task>> getTasks() async {
    return Future.delayed(Durations.medium1, () => _tasks);
  }
}

