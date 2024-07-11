import 'package:flutter/material.dart';

import '../../constants/num_constants.dart';

class BaseFadeAnimatedSwitcher extends StatelessWidget {
  const BaseFadeAnimatedSwitcher({
    super.key,
    required this.child,
    this.stackAlignment,
    this.durationMs,
    this.curve = Curves.easeInOutBack,
  });
  final Widget child;
  final AlignmentGeometry? stackAlignment;
  final Curve curve;
  final int? durationMs;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: curve,
      switchOutCurve: curve,
      duration:  Duration(
        milliseconds: durationMs ?? NumConstants.duration800,
      ),
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: stackAlignment ?? Alignment.centerLeft,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
