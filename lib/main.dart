import 'package:flutter/material.dart';
import 'package:my_sqflite/screens/add_user_screen.dart';
import 'package:my_sqflite/screens/sqflite_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySqfLite(),
      routes: {
        '/list': (context) => const MySqfLite(),
        '/editar': (context) => const AddUsers()
      },
    );
  }
}
