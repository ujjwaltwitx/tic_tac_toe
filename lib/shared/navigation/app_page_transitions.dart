import 'package:flutter/material.dart';

/// Swap [AppPageTransitions.current] to try another animation.
enum AppPageTransition {
  fade,
  fadeScale,
  slideLeft,
  slideUp,
  none,
}

class AppPageTransitions {
  AppPageTransitions._();

  /// Active transition for every named route.
  static const AppPageTransition current = AppPageTransition.fade;

  static const Duration duration = Duration(milliseconds: 280);
  static const Duration reverseDuration = Duration(milliseconds: 220);

  static PageRoute<T> route<T>({
    required WidgetBuilder builder,
    required RouteSettings settings,
    AppPageTransition? style,
  }) {
    final chosen = style ?? current;
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      reverseTransitionDuration: reverseDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return builder(context);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _build(chosen, animation, secondaryAnimation, child);
      },
    );
  }

  static Widget _build(
    AppPageTransition style,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final outgoing = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeInCubic,
    );

    switch (style) {
      case AppPageTransition.none:
        return child;
      case AppPageTransition.fade:
        return FadeTransition(
          opacity: curved,
          child: FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0).animate(outgoing),
            child: child,
          ),
        );
      case AppPageTransition.fadeScale:
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
            child: child,
          ),
        );
      case AppPageTransition.slideLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      case AppPageTransition.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.06),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
    }
  }
}
