import 'package:flutter/material.dart';
import 'package:lab5flutter/screen/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGV Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepOrange,
          secondary: Colors.deepOrange.shade700,
        ),
        useMaterial3: true,
        fontFamily: 'sans-serif',
      ),
      home: const Homescreen(),
    );
  }
}
