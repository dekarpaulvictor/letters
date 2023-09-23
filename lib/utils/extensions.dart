import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  // Dimensions

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // Navigator

  Future<T?> push<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  void pop<T extends Object?>([T? result]) {
    return Navigator.of(this).pop<T>(result);
  }

  // SnackBar

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
