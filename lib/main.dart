import 'package:flutter/material.dart';
import 'package:rice_trax/Dashboard.dart';
import 'package:rice_trax/RiceStock.dart';

void main() {
  runApp(RiceTraxApp());
}

class RiceTraxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}