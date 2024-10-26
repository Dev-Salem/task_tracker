import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_tracker/tasks/core/app_colors.dart';
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
          brightness: Brightness.dark),
      // theme: ThemeData(
      //   useMaterial3: true,
      // ),
      themeMode: ThemeMode.dark,
      home: const TasksScreen(),
    );
  }
}
