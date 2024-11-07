import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/tasks/data/task_repository.dart';
import 'package:task_tracker/tasks/domain/task.dart';

class TasksNotifier extends AsyncNotifier<List<Task>> {
  @override
  FutureOr<List<Task>> build() async {
    return ref.watch(taskRepositoryProvider).getTasks();
  }

  Future<void> getTasks() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.watch(taskRepositoryProvider).getTasks());
  }

  Future<void> addTask(
      String taskName, TimeOfDay start, TimeOfDay end, Color color) async {
    await ref
        .watch(taskRepositoryProvider)
        .addTask(taskName, start, end, color);
    await getTasks();
  }

  Future<void> addSubTask(String taskId, String taskName, Color color) async {
    await ref.watch(taskRepositoryProvider).addSubTask(taskId, taskName, color);
  }

  Future<void> checkSubTask(String taskId, String subTaskId) async {
    await ref.watch(taskRepositoryProvider).checkSubTask(taskId, subTaskId);
  }
}

final tasksAsyncProvider =
    AsyncNotifierProvider<TasksNotifier, List<Task>>(TasksNotifier.new);
