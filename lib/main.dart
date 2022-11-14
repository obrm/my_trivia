import 'package:flutter/material.dart';
import 'package:my_trivia/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Trivia',
      theme: ThemeData(
        fontFamily: 'ArchitectsDaughter',
        scaffoldBackgroundColor: const Color.fromRGBO(
          31,
          31,
          31,
          1.0,
        ),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
