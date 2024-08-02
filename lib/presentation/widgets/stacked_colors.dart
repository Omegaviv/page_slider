import 'package:flutter/material.dart';
import 'package:page_slider_example/domain/random_color_object.dart';
import 'package:page_slider_example/presentation/widgets/color_object_widget.dart';
import 'package:page_slider_example/presentation/widgets/motion_blur_wrapper.dart';

class StackedColor extends StatelessWidget {
  const StackedColor(
      {super.key,
      required this.randomColors,
      required PageController pageController,
      required this.screenWidth,
      required this.page})
      : _pageController = pageController;

  final List<RandomColorObject> randomColors;
  final PageController _pageController;
  final double screenWidth;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: randomColors.map(
        (widgetObject) {
          return Positioned(
            top: widgetObject.top,
            left: page == 1
                ? widgetObject.left -
                    (_pageController.position.haveDimensions
                        ? (_pageController.page ?? 0.0) *
                            (screenWidth - widgetObject.left) *
                            ((screenWidth - widgetObject.left) *
                                2 /
                                screenWidth) *
                            1.5
                        : 0.0)
                : null,
            right: page == 2
                ? widgetObject.left -
                    (widgetObject.left) * 1.5 +
                    (_pageController.position.haveDimensions
                        ? (_pageController.page ?? 0.0) *
                            (widgetObject.left) *
                            1.5
                        : 0.0)
                : null,
            child: MotionBlurWrapper(
              page: page,
              pageController: _pageController,
              child: ColouredObject(widgetObject: widgetObject),
            ),
          );
        },
      ).toList(),
    );
  }
}
