import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/plans/planPage.dart';
import 'package:workhub_web/src/views/utils/response.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: LargeChild(),
      mobile: SmallChild(),
    );
  }
}

class LargeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: .6,
            child: Image.network("assets/homepage.png", scale: .85),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .6,
            child: Padding(
              padding: EdgeInsets.only(left: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Olá!",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Regular",
                          color: Colors.black87)),
                  RichText(
                    text: TextSpan(
                        text: "Bem-vindo a ",
                        style: TextStyle(fontSize: 60, color: Colors.black87),
                        children: [
                          TextSpan(
                              text: "Work-Hub",
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(177, 47, 47, 1)))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Text(
                        "Divulgue seus espaços de coworking com planos a partir de R\$ 39,90 mensais"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(177, 47, 47, 1),
                                Color.fromRGBO(255, 128, 128, 1),
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
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
                          child: Text("Registre-se",
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
                            return PlanPage();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SmallChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Olá!",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat-Regular"),
            ),
            RichText(
              text: TextSpan(
                text: 'Bem-vindo a ',
                style: TextStyle(fontSize: 40, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Work-Hub',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Color.fromRGBO(177, 47, 47, 1))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20),
              child: Text(
                  "Divulgue seus espaços de coworking com planos a partir de R\$ 39,90 mensais"),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.network(
                "assets/homepage.png",
                scale: 1,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 30,
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
                    child: Text("Registre-se",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1,
                            fontFamily: "Montserrat-Bold")),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
