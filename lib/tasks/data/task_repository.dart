import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/tasks/domain/subtask.dart';
import 'package:task_tracker/tasks/domain/task.dart';
import 'package:uuid/uuid.dart';

class TaskRepository {
  List<Task> _tasks = [..._initialTasks];
  final Uuid uuid = const Uuid();

  Future<List<Task>> getTasks() async => _tasks;

  Future<void> addTask(
      String taskName, TimeOfDay start, TimeOfDay end, Color color) async {
    final task = Task(
      id: uuid.v4(),
      task: taskName,
      date: DateTime.now(),
      isDone: false,
      cardColor: color,
      startTime: start,
      endTime: end,
      subtasks: const [],
    );
    _tasks = [..._tasks, task];
  }

  Future<void> addSubTask(String taskId, String taskName, Color color) async {
    final taskIndex = _tasks.indexWhere((x) => x.id == taskId);
    if (taskIndex != -1) {
      final task = _tasks[taskIndex];
      final newSubtask = Subtask(
        id: uuid.v4(),
        name: taskName,
        cardColor: color,
        isDone: false,
      );
      final updatedTask = task.copyWith(
        subtasks: [...task.subtasks, newSubtask],
      );
      _tasks = [..._tasks..[taskIndex] = updatedTask];
    }
  }

  Future<void> checkSubTask(String taskId, String subTaskId) async {
    final taskIndex = _tasks.indexWhere((x) => x.id == taskId);
    if (taskIndex != -1) {
      final task = _tasks[taskIndex];
      final updatedSubtasks = task.subtasks.map((subtask) {
        if (subtask.id == subTaskId) {
          return subtask.copyWith(isDone: !subtask.isDone);
        }
        return subtask;
      }).toList();

      final updatedTask = task.copyWith(subtasks: updatedSubtasks);
      _tasks = [..._tasks..[taskIndex] = updatedTask];
    }
  }
}

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});

final taskProvider = FutureProvider.family<Task, String>((ref, taskId) async {
  final tasks = await ref.watch(taskRepositoryProvider).getTasks();
  return tasks.firstWhere((task) => task.id == taskId);
});

final _initialTasks = [
  Task(
      id: DateTime.now().toString(),
      task: "Design Meeting",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.yellowAccent,
      startTime: const TimeOfDay(hour: 12, minute: 10),
      endTime: const TimeOfDay(hour: 7, minute: 20),
      subtasks: [
        Subtask(
            id: const Uuid().v4(),
            name: "Set up a video conference ",
            isDone: false,
            cardColor: Colors.amberAccent),
        Subtask(
            id: const Uuid().v4(),
            name: "Prepare the meeting room ",
            isDone: true,
            cardColor: Colors.orangeAccent),
        Subtask(
            id: const Uuid().v4(),
            name: "Work on the backend ",
            isDone: false,
            cardColor: Colors.teal),
        Subtask(
            id: const Uuid().v4(),
            name: "Work on the frontend ",
            isDone: false,
            cardColor: Colors.indigo),
        Subtask(
            id: const Uuid().v4(),
            name: "Praise @Dev_Salem0",
            isDone: false,
            cardColor: Colors.redAccent),
      ]),
  Task(
      id: DateTime.now().toString(),
      task: "Daily Project",
      date: DateTime.now(),
      isDone: false,
      cardColor: Colors.purpleAccent,
      startTime: const TimeOfDay(hour: 13, minute: 30),
      endTime: const TimeOfDay(hour: 8, minute: 40),
      subtasks: [
        Subtask(
            id: const Uuid().v4(),
            name: "Set up a video conference",
            isDone: false,
            cardColor: Colors.amberAccent),
        Subtask(
            id: const Uuid().v4(),
            name: "Prepare the meeting room",
            isDone: true,
            cardColor: Colors.orangeAccent),
        Subtask(
            id: const Uuid().v4(),
            name: "Work on the backend",
            isDone: false,
            cardColor: Colors.teal),
        Subtask(
            id: const Uuid().v4(),
            name: "Work on the frontend",
            isDone: false,
            cardColor: Colors.indigo),
      ]),
  Task(
      id: DateTime.now().toString(),
      task: "Weekly Planning",
      date: DateTime.now(),
      isDone: false,
      subtasks: [
        Subtask(
            id: const Uuid().v4(),
            name: "Set up a video conference",
            isDone: false,
            cardColor: Colors.amberAccent),
        Subtask(
            id: const Uuid().v4(),
            name: "Prepare the meeting room",
            isDone: true,
            cardColor: Colors.orangeAccent),
        Subtask(
            id: const Uuid().v4(),
            name: "Work on the backend",
            isDone: false,
            cardColor: Colors.teal),
        Subtask(
            id: const Uuid().v4(),
            name: "Work on the frontend",
            isDone: false,
            cardColor: Colors.indigo),
      ],
      cardColor: Colors.greenAccent,
      startTime: const TimeOfDay(hour: 2, minute: 50),
      endTime: const TimeOfDay(hour: 4, minute: 00)),
];
