import 'package:flutter/material.dart';
import 'package:lab8flutter/screen/post_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Implement the main app widget
    return MaterialApp(
      title: 'Lab 8 API Post List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostListScreen(),
    );
  }
}

