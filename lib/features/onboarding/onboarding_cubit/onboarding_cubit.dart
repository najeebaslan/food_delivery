import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/num_constants.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  int indexIndicator = 0;
  bool isAnimationHasStarted = false;

  late AnimationController animationController;
  late Tween<double> animation;

  late Tween<double> firstColorTweenAnimation;
  late Tween<double> lastColorTweenAnimation;

  late bool completedFirstAnimation;

  late double topPositionedCircleRed;
  late double leftPositionedCircleRed;

  late double topPositionedCircleGreen;
  late double leftPositionedCircleGreen;

  void nextIndicator({int? index}) async {
    if (index != null) {
      indexIndicator = index;
    } else {
      if (indexIndicator == 2) return;
      indexIndicator = indexIndicator == 2 ? 0 : indexIndicator + 1;
    }
    emit(NextIndicatorOnboarding(indexIndicator));
  }

  void initAnimation() {
    topPositionedCircleRed = 340.h;
    leftPositionedCircleRed = 20.w;

    topPositionedCircleGreen = 100.h;
    leftPositionedCircleGreen = 150.w;

    completedFirstAnimation = false;
    Future.delayed(
      const Duration(seconds: 2),
      () {
        animation = Tween<double>(begin: 0, end: math.pi / 1.5);
        isAnimationHasStarted = true;

        topPositionedCircleRed = 180.h;
        leftPositionedCircleRed = -10.w;

        topPositionedCircleGreen = 130.h;
        leftPositionedCircleGreen = 250.w;

        animationController.forward();
        firstColorTweenAnimation = Tween<double>(begin: 0.9, end: 0.0);
        emit(InitAnimationOnboarding());
        startNextAnimationForCircles();
      },
    );
  }

  void startNextAnimationForCircles() {
    animationController.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(const Duration(milliseconds: NumConstants.duration800),
              () {
            if (completedFirstAnimation == false) {
              animationController.reset();
              animationController.forward();

              topPositionedCircleRed = 80.h;
              leftPositionedCircleRed = 50.w;

              topPositionedCircleGreen = 250.h;
              leftPositionedCircleGreen = 290.w;

              lastColorTweenAnimation = Tween<double>(begin: 0.0, end: 1);
              completedFirstAnimation = true;
              emit(CompletedFirstAnimationOnboarding());
            }
          });
        }
      },
    );
  }

  Color onEndAnimatedColor(Color color) {
    return color.withOpacity(
      isAnimationHasStarted ? lastColorTweenAnimation.evaluate(animationController) : 0,
    );
  }

  Color onStartAnimatedColor(Color color) {
    return color.withOpacity(
      isAnimationHasStarted ? firstColorTweenAnimation.evaluate(animationController) : 0,
    );
  }
}
