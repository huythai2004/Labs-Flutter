import 'package:flutter/material.dart';

class Exercise4 extends StatelessWidget {
  const Exercise4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 4 – App Structure')),
      drawer: const Drawer(
        child: Center(child: Text('Navigation Drawer')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text(
          'Scaffold provides app structure',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
