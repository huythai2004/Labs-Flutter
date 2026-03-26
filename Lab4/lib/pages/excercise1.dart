import 'package:flutter/material.dart';

class Exercise1 extends StatelessWidget {
  const Exercise1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 – Core Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Flutter Core Widgets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Icon(Icons.favorite, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Image.network(
              'https://flutter.dev/images/flutter-logo-sharing.png',
              height: 100,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.info),
                title: const Text('ListTile inside Card'),
                subtitle: const Text('This is a core widget demo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
