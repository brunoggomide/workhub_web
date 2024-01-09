import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../auth/login/loginPage.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 120,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(177, 47, 47, 1),
                  shape: BoxShape.rectangle,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Work-Hub'),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(177, 47, 47, 1),
                    Color.fromRGBO(255, 128, 128, 1),
                  ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.3),
                        offset: Offset(0, 8),
                        blurRadius: 8)
                  ]),
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Text("Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                          fontFamily: "Montserrat-Bold")),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) {
                    return LoginPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
