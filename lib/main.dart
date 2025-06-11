import 'package:flutter/material.dart';
import 'package:tugas_13_bayu/main/edit.dart';
import 'package:tugas_13_bayu/main/listproduct.dart';
import 'package:tugas_13_bayu/main/login.dart';
import 'package:tugas_13_bayu/main/navBotom.dart';
import 'package:tugas_13_bayu/main/tambah.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: LoginPage(),
    );
  }
}
