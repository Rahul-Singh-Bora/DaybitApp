import 'package:flutter/material.dart';

/// Navigation utility for managing app navigation
class AppNavigation {
  AppNavigation._();

  /// Navigate to a new screen
  static Future<T?> push<T>(BuildContext context, Widget screen) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Navigate to a new screen and remove all previous routes
  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget screen, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (context) => screen),
      predicate ?? (route) => false,
    );
  }

  /// Replace the current screen with a new one
  static Future<T?> pushReplacement<T, TO>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.pushReplacement<T, TO>(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Navigate to a new screen with custom transition
  static Future<T?> pushWithTransition<T>(
    BuildContext context,
    Widget screen, {
    Duration duration = const Duration(milliseconds: 300),
    RouteTransitionsBuilder? transitionsBuilder,
  }) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: duration,
        transitionsBuilder:
            transitionsBuilder ??
            (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
      ),
    );
  }

  /// Navigate to a new screen with slide transition
  static Future<T?> pushWithSlideTransition<T>(
    BuildContext context,
    Widget screen, {
    Duration duration = const Duration(milliseconds: 300),
    Duration? reverseTransitionDuration,
    SlideDirection direction = SlideDirection.right,
  }) {
    Offset begin;
    switch (direction) {
      case SlideDirection.left:
        begin = const Offset(-1.0, 0.0);
        break;
      case SlideDirection.right:
        begin = const Offset(1.0, 0.0);
        break;
      case SlideDirection.up:
        begin = const Offset(0.0, -1.0);
        break;
      case SlideDirection.down:
        begin = const Offset(0.0, 1.0);
        break;
    }

    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: duration,
        reverseTransitionDuration: reverseTransitionDuration ?? duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
      ),
    );
  }

  /// Pop the current screen
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// Pop until a specific route
  static void popUntil(
    BuildContext context,
    bool Function(Route<dynamic>) predicate,
  ) {
    Navigator.popUntil(context, predicate);
  }

  /// Check if can pop
  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }
}

/// Enum for slide transition directions
enum SlideDirection { left, right, up, down }
