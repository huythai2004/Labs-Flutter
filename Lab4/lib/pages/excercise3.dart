import 'package:flutter/material.dart';

class Exercise3 extends StatelessWidget {
  const Exercise3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 – Layout Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.star, size: 40),
                Icon(Icons.star, size: 40),
                Icon(Icons.star, size: 40),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Column Item 1'),
                Text('Column Item 2'),
                Text('Column Item 3'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
