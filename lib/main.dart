import 'package:flutter/material.dart';
import 'package:jingstagram/pages/home_page.dart';
import 'package:jingstagram/pages/login_page.dart';
import 'package:jingstagram/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jingstagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'register': (context) => RegisterPage(),
        'login': (context) => LoginPage(),
      },
    );
  }
}
