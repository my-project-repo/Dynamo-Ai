import 'package:flutter/material.dart';

import 'home_page/home.dart';

class myAiApp extends StatelessWidget {
  const myAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: myHomePage(),
    );
  }
}
