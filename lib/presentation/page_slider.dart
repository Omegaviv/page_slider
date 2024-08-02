import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
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
      body: Column(
        children: [
          RiverPodWidget(),
          Expanded(
            child: PageView(
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
          ),
        ],
      ),
    );
  }
}

class RiverPodWidget extends ConsumerWidget {
  const RiverPodWidget({super.key});

  Future<void> shoeError(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(mockProvider);

    ref.listen<AsyncValue<Object>>(
      mockProvider,
      (_, state) => state.whenOrNull(
        error: (error, _) {
          shoeError(context);
        },
      ),
    );

    return provider.when(
        data: (data) => Text(data.toString()),
        error: (e, _) {
          return Container();
        },
        loading: () => const CircularProgressIndicator());
  }
}
