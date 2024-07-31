import 'package:flutter/material.dart';
import 'package:page_slider_example/data/generator_repo.dart';
import 'package:page_slider_example/domain/random_color_object.dart';
import 'package:page_slider_example/presentation/widgets/stacked_colors.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({super.key});

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  final PageController _pageController = PageController();

  final RandomWidgetGenerator generatorRepo = RandomWidgetGenerator();

  List<RandomColorObject> firstPage = [];

  List<RandomColorObject> secondPage = [];

  void reGenrateWidgets(double screenHeight, double screenWidth) {
    firstPage =
        generatorRepo.generateRandomWidgets(7, screenHeight, screenWidth);
    secondPage =
        generatorRepo.generateRandomWidgets(7, screenHeight, screenWidth);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (firstPage.isEmpty) {
      firstPage =
          generatorRepo.generateRandomWidgets(7, screenHeight, screenWidth);
    }
    if (secondPage.isEmpty) {
      secondPage =
          generatorRepo.generateRandomWidgets(7, screenHeight, screenWidth);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                reGenrateWidgets(screenHeight, screenWidth);
              },
              icon: const Icon(Icons.replay_outlined))
        ],
        title: Text(
          'Transfer',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, _) {
              return StackedColor(
                  page: 1,
                  randomColors: firstPage,
                  pageController: _pageController,
                  screenWidth: screenWidth);
            },
          ),
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return StackedColor(
                  page: 2,
                  randomColors: secondPage,
                  pageController: _pageController,
                  screenWidth: screenWidth);
            },
          ),
        ],
      ),
    );
  }
}
