import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomRectTween extends Tween<Rect> {
  CustomRectTween({
    required Rect begin,
    required Rect end,
    this.tension = 1.70158,
  }) : super(begin: begin, end: end);

  final double tension;

  @override
  Rect lerp(double t) {
    double easeInOutBackValue = easeInOutBack(t, tension: tension);

    double animatedX = ui.lerpDouble(begin!.left, end!.left, easeInOutBackValue)!;
    double animatedY = ui.lerpDouble(begin!.top, end!.top, easeInOutBackValue)!;
    double animatedWidth = ui.lerpDouble(begin!.width, end!.width, easeInOutBackValue)!;
    double animatedHeight =
        ui.lerpDouble(begin!.height, end!.height, easeInOutBackValue)!;

    return Rect.fromLTWH(animatedX, animatedY, animatedWidth, animatedHeight);
  }
}

/// Custom easing function that mimics the "easeInOutBack" behavior.
///
/// This function takes a value [t] between 0 and 1 and returns a new value
/// that represents the desired easing behavior.
///
/// The easeInOutBack curve starts by moving backwards slightly, creating an
/// "easing-in" effect. It then overshoots the final position and settles back
/// to the final position, creating an "easing-out" effect.
///
/// The [tension] parameter controls the amount of "back" movement.
double easeInOutBack(double t, {double tension = 1.70158}) {
  // Normalize the input value to be between 0 and 2
  double normalizedT = t * 2;

  // First half of the animation (t < 0.5)
  if (normalizedT < 1) {
    return (normalizedT * normalizedT * ((tension + 1) * normalizedT - tension)) / 2;
  }
  // Second half of the animation (t >= 0.5)
  else {
    normalizedT -= 2;
    return (normalizedT * normalizedT * ((tension + 1) * normalizedT + tension) + 2) / 2;
  }
}
