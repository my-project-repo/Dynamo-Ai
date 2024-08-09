import 'package:flutter/material.dart';

import 'home_page/home.dart';
void main ()=>runApp(const myAiApp());
class myAiApp extends StatelessWidget {
  const myAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myHomePage(),
    );
  }
}
