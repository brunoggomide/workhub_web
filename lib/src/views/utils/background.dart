import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 20,
              child: Container(
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SafeArea(child: child),
            ),
          ],
        ),
      ),
    );
  }
}
