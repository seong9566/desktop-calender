import 'package:flutter/material.dart';
import 'package:windows_calender_app/view/home/home_view.dart';

void main() {
  runApp(const WindowsCalenderApp());
}

class WindowsCalenderApp extends StatelessWidget {
  const WindowsCalenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Windows Calender App',
      home: HomeView(),
    );
  }
}
