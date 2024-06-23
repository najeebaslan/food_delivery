

import 'dart:async';

import 'package:flutter/material.dart';

class AnimationSlideTransition extends StatefulWidget {
  final int delay;
  final Widget child;
  final Curve? curve;
  final String direction;
  final double? startFromBottom;
  final double? startFromLift;

  final int? milliseconds;
  const AnimationSlideTransition({
    super.key,
    this.curve,
    this.milliseconds,
    this.startFromLift,
    required this.delay,
    required this.child,
    this.startFromBottom,
    required this.direction,
  });

  @override
  State<AnimationSlideTransition> createState() => _AnimationSlideTransitionState();
}

class _AnimationSlideTransitionState extends State<AnimationSlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.milliseconds ?? 800,
      ),
    );
    final curve = CurvedAnimation(
      curve: widget.curve ?? Curves.decelerate,
      parent: _controller,
    );

    _animOffset = widget.direction == 'left'
        ? Tween<Offset>(
            begin: Offset(widget.startFromLift ?? 0.35, 0.0),
            end: Offset.zero,
          ).animate(curve)
        : Tween<Offset>(
            begin: Offset(0.0, widget.startFromBottom ?? 0.35),
            end: Offset.zero,
          ).animate(curve);

    Timer(
      Duration(milliseconds: widget.delay),
      () {
        if (mounted) _controller.forward();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
