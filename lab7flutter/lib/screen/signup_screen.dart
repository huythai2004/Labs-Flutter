import 'package:flutter/material.dart';
import '../widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Signup')),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SignupForm(),
        ),
      ),
    );
  }
}