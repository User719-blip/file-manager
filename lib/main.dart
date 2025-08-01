import 'package:file_manager/core/theme/theme.dart';
import 'package:file_manager/feature/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Manager',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

