import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/homepage/components/body.dart';
import 'package:workhub_web/src/views/homepage/components/navBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            Body(),
          ],
        ),
      ),
    );
  }
}
