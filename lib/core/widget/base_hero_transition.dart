import 'package:flutter/material.dart';

class BaseHeroTransition extends StatelessWidget {
  const BaseHeroTransition({
    super.key,
    required this.heroTag,
    required this.heroWidget,
    required this.animatedBuilderChild,
    required this.animatedBuilderBuilder,
    required this.createRectTween,
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

  final Tween<Rect?> Function(
    Rect? begin,
    Rect? end,
  ) createRectTween;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      flightShuttleBuilder: (_, Animation<double> animation, __, ___, ____) {
        final rotationAnimation = Tween<double>(
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
      createRectTween: createRectTween,
      child: heroWidget,
    );
  }
}
