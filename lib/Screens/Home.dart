import 'package:flutter/material.dart';

class Homehive extends StatelessWidget {
  final String email;

  const Homehive({Key? key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
            "Welcome $email",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
    );
  }
}