import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/tasks/core/animations.dart';
import 'package:task_tracker/tasks/domain/task.dart';
import 'package:task_tracker/tasks/presentation/screens/task_details_screen.dart';
import 'package:task_tracker/tasks/presentation/screens/tasks_screen.dart';

void main() {
  runApp(DevicePreview(
      enabled: false,
      builder: (context) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(156, 27, 27, 27),
          fontFamily: "Helvetica",
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
          textButtonTheme: const TextButtonThemeData(style: ButtonStyle()),
          disabledColor: Colors.red,
          brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          'tasks' => NoAnimationTransition(
              builder: (context) => const TasksScreen(),
            ),
          'task_details' => NoAnimationTransition(
              builder: (context) =>
                  TaskDetailsScreen(task: settings.arguments as Task),
            ),
          _ => NoAnimationTransition(builder: (context) => const TasksScreen())
        };
      },
      home: const TasksScreen(),
    );
  }
}
