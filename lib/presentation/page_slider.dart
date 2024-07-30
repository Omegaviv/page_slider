import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:page_slider_example/data/generator_repo.dart';
import 'package:page_slider_example/domain/random_color_object.dart';

class PageSlider extends StatelessWidget {
  PageSlider({super.key});

  final PageController _pageController = PageController();
  final RandomWidgetGenerator generatorRepo = RandomWidgetGenerator();

  List<RandomColorObject> firstPage = [];

  List<RandomColorObject> secondPage = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (firstPage.isEmpty) {
      firstPage =
          generatorRepo.generateRandomWidgets(7, screenHeight, screenWidth);
      firstPage
          .add(RandomColorObject(color: Colors.transparent, left: 0, top: 0));
    }
    if (secondPage.isEmpty) {
      secondPage =
          generatorRepo.generateRandomWidgets(7, screenHeight, screenWidth);
      secondPage
          .add(RandomColorObject(color: Colors.transparent, left: 0, top: 0));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Page Slider Example')),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, _) {
              return Stack(
                children: firstPage.asMap().entries.map(
                  (widget) {
                    return Positioned(
                      top: widget.value.top,
                      left: widget.value.left -
                          (_pageController.position.haveDimensions
                              ? (_pageController.page ?? 0.0) *
                                  (screenWidth - widget.value.left) *
                                  1.5
                              : 0.0),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                            sigmaX: _pageController.position.haveDimensions
                                ? ((_pageController.page ?? 0.0).abs() * 20)
                                : 0.001,
                            sigmaY: _pageController.position.haveDimensions
                                ? ((_pageController.page!).abs() * 3)
                                : 0.001),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: widget.value.color,
                              shape: BoxShape.circle),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return Stack(
                children: secondPage.map((widget) {
                  return Positioned(
                    top: widget.top,
                    right: widget.left -
                        (widget.left) * 1.5 +
                        (_pageController.position.haveDimensions
                            ? (_pageController.page ?? 0.0) *
                                (widget.left) *
                                1.5
                            : 0.0),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(
                          sigmaX: _pageController.position.haveDimensions
                              ? ((1 - _pageController.page!).abs() * 20)
                              : 0.001,
                          sigmaY: _pageController.position.haveDimensions
                              ? ((1 - _pageController.page!).abs() * 3)
                              : 0.001),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: widget.color, shape: BoxShape.circle),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
