import 'package:flutter/material.dart';

class Exercise5 extends StatelessWidget {
  const Exercise5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 – UI Fixes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Proper padding, spacing and overflow handling',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'This text will not overflow because of padding and layout fixes.',
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
