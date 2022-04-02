import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mycalculatorapp/myhomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'My Calculator App - 1800003317'),
    );
  }
}


