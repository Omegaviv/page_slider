import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_slider_example/domain/random_color_object.dart';

class RandomWidgetGenerator {
  static final Random _random = Random();
  static final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange
  ];
  RandomWidgetGenerator();
  List<RandomColorObject> generateRandomWidgets(
      int count, double contextHeight, double contextWidget) {
    List<RandomColorObject> widgets = [];

    for (int i = 0; i < count; i++) {
      double top = _random.nextDouble() * (contextHeight - 200);
      double left = _random.nextDouble() * (contextWidget - 100);
      Color color = _colors[_random.nextInt(_colors.length)];

      widgets.add(RandomColorObject(top: top, left: left, color: color));
    }
    widgets.add(RandomColorObject(color: Colors.transparent, left: 0, top: 0));
    return widgets;
  }

  Future<Object> mockAPI() async {
    await Future.delayed(const Duration(seconds: 2));

    bool hasError = _random.nextBool();

    if (hasError) {
      throw Exception("Error has occured");
    } else {
      return "Result Data";
    }
  }
}

final mockProvider = FutureProvider<Object>((ref) async {
  return RandomWidgetGenerator().mockAPI();
});
