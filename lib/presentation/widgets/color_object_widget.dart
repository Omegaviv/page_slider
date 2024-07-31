import 'package:flutter/material.dart';
import 'package:page_slider_example/domain/random_color_object.dart';

class ColouredObject extends StatelessWidget {
  const ColouredObject({
    super.key,
    required this.widgetObject,
  });

  final RandomColorObject widgetObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration:
          BoxDecoration(color: widgetObject.color, shape: BoxShape.circle),
    );
  }
}
