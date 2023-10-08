import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme:
            ThemeData().colorScheme.copyWith(secondary: Colors.lightBlue),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}
