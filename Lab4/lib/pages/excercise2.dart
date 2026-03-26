import 'package:flutter/material.dart';

class Exercise2 extends StatefulWidget {
  const Exercise2({super.key});

  @override
  State<Exercise2> createState() => _Exercise2State();
}

class _Exercise2State extends State<Exercise2> {
  double sliderValue = 50;
  bool switchValue = false;
  String selectedOption = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 – Input Controls')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Slider(
              value: sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: sliderValue.toString(),
              onChanged: (value) {
                setState(() => sliderValue = value);
              },
            ),
            SwitchListTile(
              title: const Text('Enable Feature'),
              value: switchValue,
              onChanged: (value) {
                setState(() => switchValue = value);
              },
            ),
            RadioListTile(
              title: const Text('Option A'),
              value: 'A',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() => selectedOption = value!);
              },
            ),
            RadioListTile(
              title: const Text('Option B'),
              value: 'B',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() => selectedOption = value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
