### README

This project demonstrates a Flutter application with a `PageView` that contains pages with animated widgets. The structure includes several folders and files organized as follows:

#### Project Structure

```
lib/
│
├── data/
│   └── generator_repo.dart
│
├── domain/
│   └── random_color_object.dart
│
├── presentation/
│   └── widgets/
│       ├── color_object_widget.dart
│       ├── motion_blur_wrapper.dart
│       ├── stacked_colors.dart
│       └── page_slider.dart
│
└── main.dart
```

#### Explanation of Each File

1. **data/generator_repo.dart**
   - Contains the `RandomWidgetGenerator` class, which generates a list of random widgets (with random positions and colors) for the animation.

2. **domain/random_color_object.dart**
   - Defines the `RandomColorObject` class, which holds the properties of each widget, such as its position (`top` and `left`) and color.

3. **presentation/widgets/color_object_widget.dart**
   - Contains the widget for displaying individual colored objects.

4. **presentation/widgets/motion_blur_wrapper.dart**
   - Contains a widget that applies a motion blur effect to its child widget.

5. **presentation/widgets/stacked_colors.dart**
   - Contains the `StackedColor` widget, which positions and animates a list of `RandomColorObject` widgets within a `Stack`.

6. **presentation/widgets/page_slider.dart**
   - Contains the `PageSlider` widget, which uses a `PageView` to display and animate the `StackedColor` widgets across different pages. It regenerates the random widgets when the refresh icon is pressed.

7. **main.dart**
   - The entry point of the Flutter application. It initializes and runs the app.

#### Logic of Animations

- **PageSlider**
  - This widget is a widget that manages the state of two pages, each containing a list of `RandomColorObject` widgets.
  - The `PageController` is used to control and listen to page changes.
  - The `reGenrateWidgets` method regenerates the widgets on both pages and triggers a rebuild using `setState`.

- **StackedColor**
  - This widget takes a list of `RandomColorObject` and positions them within a `Stack`.
  - The position and blur effect of each widget are animated based on the current page value from the `PageController`.

- **Motion Blur Effect**
  - The motion blur effect is applied using a `BackdropFilter` in the `MotionBlurWrapper` widget. The blur intensity changes dynamically based on the page position.

#### How to Run

1. Ensure you have Flutter installed and set up on your machine.
2. Clone the repository and navigate to the project directory.
3. Run `flutter pub get` to install the required dependencies.
4. Run `flutter run` to launch the application on your preferred device or emulator.

This application showcases how to use `PageView` and `AnimatedBuilder` to create smooth animations with dynamic content in Flutter.