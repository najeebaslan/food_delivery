import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/num_constants.dart';
import '../../../core/widget/custom_painters/onboarding_circle_bold_red_custom_painter.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class AnimationCircleBoldRed extends StatelessWidget {
  const AnimationCircleBoldRed({
    super.key,
    required this.onboardingCubit,
    required this.onboardingHeroTags,
  });

  final OnboardingCubit onboardingCubit;
  final String onboardingHeroTags;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => current is InitAnimationOnboarding,
      builder: (context, state) {
        return AnimatedBuilder(
          animation: onboardingCubit.animationController,
          builder: (context, child) {
            return AnimatedPositioned(
              curve: Curves.easeInOut,
              top: onboardingCubit.topPositionedCircleRed,
              left: onboardingCubit.leftPositionedCircleRed,
              duration: Duration(
                milliseconds: 1050,
              ),
              child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(
                      onboardingCubit.isStartAnimation
                          ? onboardingCubit.animation
                              .evaluate(onboardingCubit.animationController)
                          : 0,
                    ),
                  child: onboardingCubit.completedFirstAnimation == false
                      ? firstWIdgetAnimation()
                      : lastWIdgetAnimation()),
            );
          },
        );
      },
    );
  }

  AnimatedCrossFade firstWIdgetAnimation() {
    return AnimatedCrossFade(
      firstChild: Hero(
        tag: onboardingHeroTags,
        child: SvgPicture.asset(
          ImagesConstants.onboardingCircleRed,
          height: 69.33.h,
          width: 69.33.w,
        ),
      ),
      secondChild: Transform.rotate(
          alignment: Alignment.center,
          angle: 4.1,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size(
                  72.33.w,
                  (72.33.w * 1.0142857142857142).toDouble(),
                ),
                painter: OnboardingCircleBoldRedCustomPainter(),
              ),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (previous, current) =>
                    current is CompletedFirstAnimationOnboarding,
                builder: (context, state) {
                  return Transform.rotate(
                    angle: 2.1,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      ImagesConstants.onboardingCircleRed,
                      height: 69.33.h,
                      width: 69.33.w,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFE8453C).withOpacity(
                          onboardingCubit.isStartAnimation
                              ? onboardingCubit.colorTweenFirstAnimation.evaluate(
                                  onboardingCubit.animationController,
                                )
                              : 0,
                        ),
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
      crossFadeState: onboardingCubit.isStartAnimation
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: Duration(
        milliseconds: NumConstants.animationDuration,
      ),
    );
  }

  AnimatedCrossFade lastWIdgetAnimation() {
    return AnimatedCrossFade(
      firstChild: Hero(
        tag: onboardingHeroTags,
        child: SvgPicture.asset(
          ImagesConstants.onboardingCircleRed,
          height: 69.33.h,
          width: 69.33.w,
        ),
      ),
      secondChild: Transform.rotate(
          alignment: Alignment.center,
          angle: 6.1,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size(
                  72.33.w,
                  (72.33.w * 1.0142857142857142).toDouble(),
                ),
                painter: OnboardingCircleBoldRedCustomPainter(
                  color: Color(0xFFE8453C).withOpacity(
                    onboardingCubit.isStartAnimation
                        ? onboardingCubit.colorTweenFirstAnimation.evaluate(
                            onboardingCubit.animationController,
                          )
                        : 0,
                  ),
                ),
              ),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (previous, current) =>
                    current is CompletedFirstAnimationOnboarding,
                builder: (context, state) {
                  return Transform.rotate(
                    angle: 4.1,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      ImagesConstants.ellipseRed,
                      height: 69.33.h,
                      width: 69.33.w,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFE8453C).withOpacity(
                          onboardingCubit.isStartAnimation
                              ? onboardingCubit.colorTweenLastAnimation.evaluate(
                                  onboardingCubit.animationController,
                                )
                              : 0,
                        ),
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
      crossFadeState: onboardingCubit.isStartAnimation
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: Duration(
        milliseconds: NumConstants.animationDuration,
      ),
    );
  }
}
