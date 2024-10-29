import 'package:flutter/material.dart';
import 'package:task_tracker/tasks/core/animations.dart';
import 'package:task_tracker/tasks/domain/task.dart';
import 'package:task_tracker/tasks/presentation/screens/task_details_screen.dart';
import 'package:task_tracker/tasks/presentation/screens/tasks_screen.dart';

void main() {
  runApp(const MyApp());
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
          textButtonTheme: const TextButtonThemeData(style: ButtonStyle()),
          disabledColor: Colors.red,
          brightness: Brightness.dark),
      // theme: ThemeData(
      //   useMaterial3: true,
      // ),
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
