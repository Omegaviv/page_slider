import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MotionBlurWrapper extends StatelessWidget {
  const MotionBlurWrapper(
      {super.key,
      required PageController pageController,
      required this.child,
      required this.page})
      : _pageController = pageController;

  final PageController _pageController;
  final Widget child;
  final int page;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
          sigmaX: _pageController.position.haveDimensions
              ? (((page == 2 ? -1 : 0.0) + (_pageController.page ?? 0.0))
                          .abs() *
                      20)
                  .clamp(0.001, 20)
              : 0.001,
          sigmaY: _pageController.position.haveDimensions
              ? (((page == 2 ? -1 : 0.0) + (_pageController.page ?? 0.0))
                      .abs() *
                  3)
              : 0.001),
      child: child,
    );
  }
}
