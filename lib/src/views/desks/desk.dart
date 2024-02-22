import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/desks/newDesk.dart';

class Desks extends StatelessWidget {
  const Desks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 20.0,
            right: 20.0,
            child: RawMaterialButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return NewDesk();
                    });
              },
              fillColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 2.0,
              padding: const EdgeInsets.all(12.0),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
