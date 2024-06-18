import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/num_constants.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  int indexIndicator = 0;
  late AnimationController animationController;
  late Tween<double> animation;
  bool isStartAnimation = false;

  late Tween<double> firstColorTweenAnimation;
  late Tween<double> lastColorTweenAnimation;

  late bool completedFirstAnimation;

  late double topPositionedCircleRed;
  late double leftPositionedCircleRed;

  late double topPositionedCircleGreen;
  late double leftPositionedCircleGreen;

  late double topPositionedCircleYellow;
  late double leftPositionedCircleYellow;

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

    topPositionedCircleYellow = 130.h;
    leftPositionedCircleYellow = 20.w;

    completedFirstAnimation = false;
    Future.delayed(
      Duration(seconds: 2),
      () {
        animation = Tween<double>(begin: 0, end: math.pi / 1.5);
        isStartAnimation = true;

        topPositionedCircleRed = 180.h;
        leftPositionedCircleRed = -10.w;

        topPositionedCircleGreen = 130.h;
        leftPositionedCircleGreen = 250.w;

        topPositionedCircleYellow = 280.h;
        leftPositionedCircleYellow = 290.w;

        animationController.forward();
        firstColorTweenAnimation = Tween<double>(begin: 0.9, end: 0.0);
        emit(InitAnimationOnboarding());
        statusListenerAnimation();
      },
    );
  }

  void statusListenerAnimation() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: NumConstants.animationDuration), () {
          if (completedFirstAnimation == false) {
            animationController
              ..reset()
              ..forward();

            topPositionedCircleRed = 80.h;
            leftPositionedCircleRed = 50.w;

            topPositionedCircleGreen = 250.h;
            leftPositionedCircleGreen = 290.w;

            topPositionedCircleYellow = 430.h;
            leftPositionedCircleYellow = -5.w;

            lastColorTweenAnimation = Tween<double>(begin: 0.0, end: 1);
            completedFirstAnimation = true;
            emit(CompletedFirstAnimationOnboarding());
          }
        });
      }
    });
  }

  Color onEndAnimatedColor(Color color) {
    return color.withOpacity(
      isStartAnimation ? lastColorTweenAnimation.evaluate(animationController) : 0,
    );
  }

  Color onStartAnimatedColor(Color color) {
    return color.withOpacity(
      isStartAnimation ? firstColorTweenAnimation.evaluate(animationController) : 0,
    );
  }
}
