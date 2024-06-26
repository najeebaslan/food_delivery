import 'package:flutter/material.dart';

class CustomRectTween extends RectTween {
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    double startX = begin!.left;
    double startY = begin!.top;
    double startWidth = begin!.width;
    double startHeight = begin!.height;

    double endX = end!.left;
    double endY = end!.top;
    double endWidth = end!.width;
    double endHeight = end!.height;

    double easeInOutBackValue = Curves.easeInOutBack.transform(t);

    double animatedX = startX + (endX - startX) * easeInOutBackValue;
    double animatedY = startY + (endY - startY) * easeInOutBackValue;
    double animatedWidth = startWidth + (endWidth - startWidth) * easeInOutBackValue;
    double animatedHeight = startHeight + (endHeight - startHeight) * easeInOutBackValue;
    return Rect.fromLTWH(animatedX, animatedY, animatedWidth, animatedHeight);
  }
}
