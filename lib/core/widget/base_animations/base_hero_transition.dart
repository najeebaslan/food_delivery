import 'package:flutter/material.dart';

import '../../utils/custom_rect_tween.dart';

class BaseHeroTransition extends StatelessWidget {
  const BaseHeroTransition({
    super.key,
    required this.heroTag,
    required this.heroWidget,
    required this.animatedBuilderChild,
    required this.animatedBuilderBuilder,
    this.endTweenAnimation,
  });

  final String heroTag;
  final Widget heroWidget;
  final double? endTweenAnimation;

  final Widget Function(
    Animation<double> animation,
    Widget? child,
  ) animatedBuilderBuilder;

  final Widget Function(
    Animation<double> animation,
  ) animatedBuilderChild;

  @override
  Widget build(BuildContext context) {
    Animation<double> rotationAnimation;
    return Hero(
      tag: heroTag,
      flightShuttleBuilder: (_, Animation<double> animation, __, ___, ____) {
        rotationAnimation = Tween<double>(
          begin: 0.0,
          end: endTweenAnimation ?? 2.3,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutBack,
          ),
        );

        return AnimatedBuilder(
          animation: rotationAnimation,
          child: animatedBuilderChild(rotationAnimation),
          builder: (context, child) {
            return animatedBuilderBuilder(
              rotationAnimation,
              child,
            );
          },
        );
      },
      createRectTween: (begin, end) {
        return CustomRectTween(
          begin: begin!,
          end: end!,
        );
      },
      child: heroWidget,
    );
  }
}
