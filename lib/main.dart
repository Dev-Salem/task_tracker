import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/tasks/core/animations.dart';
import 'package:task_tracker/tasks/core/app_colors.dart';
import 'package:task_tracker/tasks/presentation/screens/task_details_screen.dart';
import 'package:task_tracker/tasks/presentation/screens/tasks_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: "Helvetica",
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
          brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          'tasks' => NoAnimationTransition(
              builder: (context) => const TasksScreen(),
            ),
          'task_details' => NoAnimationTransition(
              builder: (context) {
                final arguments =
                    settings.arguments as (String taskId, Color color);
                return TaskDetailsScreen(
                  taskId: arguments.$1,
                  backgroundColor: arguments.$2,
                );
              },
            ),
          _ => NoAnimationTransition(builder: (context) => const TasksScreen())
        };
      },
      home: const TasksScreen(),
    );
  }
}
