import 'package:flutter/material.dart';
import 'package:page_slider_example/presentation/page_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageSlider(),
    );
  }
}
