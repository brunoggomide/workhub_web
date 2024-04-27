import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/auth/login/loginPage.dart';
import 'package:workhub_web/src/views/auth/signUp/signUpPage.dart';
import 'package:workhub_web/src/views/base/sideBar.dart';
import 'package:workhub_web/src/views/homepage/homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Erro ao inicializar o Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work-Hub',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), //somente para testes DELETAR DPS
    );
  }
}
