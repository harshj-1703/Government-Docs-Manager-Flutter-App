// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import './main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    navigateToMain();
    super.initState();
  }

  navigateToMain() async {
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        ((route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 146, 189, 232),
              Color.fromARGB(255, 0, 96, 192),
              Color.fromARGB(255, 0, 76, 153),
              Color.fromARGB(255, 0, 96, 192),
              Color.fromARGB(255, 146, 189, 232),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(80.0),
              child: Image.asset('assets/images/logo.png'),
            ),
            Text(
              "Developed By",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Harsh Jolapara",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
