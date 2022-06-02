import 'package:flutter/material.dart';
import 'package:uber_eats/app/Home/home_menu_with_scrollable_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeMenuWithTab(),
    );
  }
}
