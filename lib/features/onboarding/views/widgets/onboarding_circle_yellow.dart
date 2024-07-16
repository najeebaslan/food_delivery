import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/num_constants.dart';
import '../../../../core/styles/app_colors.dart';

class OnboardingCircleYellow extends StatefulWidget {
  const OnboardingCircleYellow({super.key});

  @override
  State<OnboardingCircleYellow> createState() => _OnboardingCircleYellowState();
}

class _OnboardingCircleYellowState extends State<OnboardingCircleYellow>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> firstColorTweenAnimation;
  late Tween<double> animation;

  bool isAnimationHasStarted = false;
  bool completedFirstAnimation = false;

  double topPositionedCircleYellow = 130.h;
  double rightPositionedCircleYellow = 290.w;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration800 - 100,
      ),
    );
    initAnimation();
  }

  void initAnimation() {
    animation = Tween<double>(begin: 0, end: 1);

    Future.delayed(const Duration(seconds: 2), () {
      topPositionedCircleYellow = 280.h;
      rightPositionedCircleYellow = 290.w;

      isAnimationHasStarted = true;
      firstColorTweenAnimation = Tween<double>(begin: 0, end: math.pi / 1.5);

      _animationController.forward();
      startNextAnimation();
    });
  }

  void startNextAnimation() {
    _animationController.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(
            const Duration(milliseconds: NumConstants.duration800),
            () {
              if (completedFirstAnimation == false) {
                completedFirstAnimation = true;

                _animationController
                  ..reset()
                  ..forward();

                topPositionedCircleYellow = context.isSmallDevice ? 350.h : 430.h;
                rightPositionedCircleYellow = -5.w;
              }
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return AnimatedPositioned(
              duration: const Duration(
                milliseconds: NumConstants.duration800,
              ),
              curve: Curves.easeInOut,
              top: topPositionedCircleYellow,
              left: rightPositionedCircleYellow,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(completedFirstAnimation
                      ? -animation.evaluate(_animationController) * 2
                      : animation.evaluate(_animationController)),
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: 5.3,
                      child: SvgPicture.asset(
                        ImagesConstants.onboardingCircleBoldYellow,
                        height: 84.33.h,
                        width: 84.33.w,
                        colorFilter: ColorFilter.mode(
                          completedFirstAnimation
                              ? AppColors.yellow
                              : (isAnimationHasStarted == false)
                                  ? AppColors.white
                                  : AppColors.yellow.withOpacity(
                                      _animationController.value,
                                    ),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      ImagesConstants.onboardingCircleBorderYellow,
                      height: 84.33.h,
                      width: 84.33.w,
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
