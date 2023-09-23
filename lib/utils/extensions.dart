import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  // Dimensions

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // Navigator

  /// `push<T extends Object?>`: This extension simplifies the process of 
  /// pushing a new page onto the navigation stack. It takes a Widget and uses 
  /// Navigator.of(this) to navigate to the provided page using a 
  /// MaterialPageRoute.
  Future<T?> push<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// `pushAndRemoveUntil<T extends Object?>`: This extension pushes a
  /// new page onto the navigation stack and removes all previous pages
  /// until the condition specified in the second
  /// argument ((route) => false) is met.
  Future<T?> pushAndRemoveUntil<T extends Object?>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  /// `pop<T extends Object?>`: This method pops the current route,
  /// optionally returning a result to the previous route.
  void pop<T extends Object?>([T? result]) {
    return Navigator.of(this).pop<T>(result);
  }

  // SnackBar

  /// `showSnackBar`: This method displays a SnackBar at the bottom of the screen associated with the current BuildContext.
  /// It takes a message and an optional color argument
  /// to customize the appearance of the SnackBar.
  void showSnackBar(String message, [Color? color]) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        padding: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color ?? Theme.of(this).colorScheme.primary,
      ),
    );
  }
}

extension DateTimeExt on DateTime {
  /// This extension provides a formatted string representation of a DateTime object.
  /// It formats the date in the format "day-month-year".
  String get format => "$day-$month-$year";
}
