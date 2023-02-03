import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/code_entry.dart';
import 'home/display_page.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CodeEntryPage(),
    );
  }
}
