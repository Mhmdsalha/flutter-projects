import 'package:counter_screen/MyApp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(main2());
}

class main2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}
