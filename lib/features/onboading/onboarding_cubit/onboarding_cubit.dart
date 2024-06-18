import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/num_constants.dart';

import '../../../core/styles/app_colors.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  int indexIndicator = 0;
  late AnimationController animationController;
  late Tween<double> animation;
  bool isStartAnimation = false;
  late Tween<double> colorTweenFirstAnimation;
  late Tween<double> colorTweenLastAnimation;
  late bool completedFirstAnimation;
  late double topPositionedCircleRed;
  late double leftPositionedCircleRed;

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
    completedFirstAnimation = false;
    Future.delayed(
      Duration(seconds: 2),
      () {
        animation = Tween<double>(begin: 0, end: math.pi / 1.5);
        isStartAnimation = true;
        topPositionedCircleRed = 180.h;
        leftPositionedCircleRed = -10.w;

        animationController.forward();
        colorTweenFirstAnimation = Tween<double>(begin: 0.9, end: 0.0);
        emit(InitAnimationOnboarding());
        StatusListenerAnimation();
      },
    );
  }

  void StatusListenerAnimation() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: NumConstants.animationDuration), () {
          if (completedFirstAnimation == false) {
            animationController
              ..reset()
              ..forward();

            topPositionedCircleRed = 80.h;
            leftPositionedCircleRed = 50.w;
            colorTweenLastAnimation = Tween<double>(begin: 0.0, end: 1);
            completedFirstAnimation = true;
            emit(CompletedFirstAnimationOnboarding());
          }
        });
      }
    });
  }

  Color get colorCircleRedLast {
    return AppColors.red.withOpacity(
      isStartAnimation ? colorTweenLastAnimation.evaluate(animationController) : 0,
    );
  }

  Color get colorCircleRedFirst {
    return AppColors.red.withOpacity(
      isStartAnimation ? colorTweenFirstAnimation.evaluate(animationController) : 0,
    );
  }
}
