import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/splash.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: 'قطرة',
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}
