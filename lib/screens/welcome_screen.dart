// ignore_for_file: prefer_const_constructors, use_super_parameters, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            "Hello",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
