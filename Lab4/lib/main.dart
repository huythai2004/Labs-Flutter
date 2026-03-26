import 'package:flutter/material.dart';
import 'package:lab4/pages/excercise1.dart';
import 'package:lab4/pages/excercise2.dart';
import 'package:lab4/pages/excercise3.dart';
import 'package:lab4/pages/excercise4.dart';
import 'package:lab4/pages/excercise5.dart';
void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 – Flutter UI Fundamentals',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundamentals'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItem(
            context,
            'Exercise 1 – Core Widgets Demo',
            const Exercise1(),
          ),
          _buildItem(
            context,
            'Exercise 2 – Input Controls Demo',
            const Exercise2(),
          ),
          _buildItem(
            context,
            'Exercise 3 – Layout Demo',
            const Exercise3(),
          ),
          _buildItem(
            context,
            'Exercise 4 – App Structure & Theme',
            const Exercise4(),
          ),
          _buildItem(
            context,
            'Exercise 5 – Common UI Fixes',
            const Exercise5(),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, Widget page) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}
