import 'package:flutter/material.dart';
import 'package:multithreaded_trading_app/view/home.dart';
import 'package:multithreaded_trading_app/view/splash.dart';
import 'package:multithreaded_trading_app/view/testing.dart';
import 'package:multithreaded_trading_app/view/testing2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
   
      
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home()
    );
  }
}

