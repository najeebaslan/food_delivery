import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widget/custom_painters/onboarding_circle_green_small_custom_painter.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class OnboardingCircleGreen extends StatelessWidget {
  const OnboardingCircleGreen({
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
              top: onboardingCubit.topPositionedCircleGreen,
              left: onboardingCubit.leftPositionedCircleGreen,
              duration: const Duration(
                milliseconds: NumConstants.animationDuration,
              ),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(
                    !onboardingCubit.completedFirstAnimation
                        ? transformZ / 2
                        : -(transformZ),
                  ),
                child: CircleGreenAnimation(
                  onboardingHeroTags: onboardingHeroTags,
                  onboardingCubit: onboardingCubit,
                ),
              ),
            );
          },
        );
      },
    );
  }

  double get transformZ {
    if (onboardingCubit.isAnimationHasStarted == false) return 0;

    return onboardingCubit.animation.evaluate(
      onboardingCubit.animationController,
    );
  }
}

class CircleGreenAnimation extends StatelessWidget {
  const CircleGreenAnimation({
    super.key,
    required this.onboardingHeroTags,
    required this.onboardingCubit,
  });

  final String onboardingHeroTags;
  final OnboardingCubit onboardingCubit;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Hero(
        tag: onboardingHeroTags,
        child: SvgPicture.asset(
          ImagesConstants.onboardingCircleBorderGreen,
          height: 69.33.h,
          width: 69.33.w,
        ),
      ),
      secondChild: Transform.rotate(
        alignment: Alignment.center,
        angle: 5,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            BlocBuilder<OnboardingCubit, OnboardingState>(
              buildWhen: (previous, current) =>
                  current is CompletedFirstAnimationOnboarding,
              builder: (context, state) {
                return Transform.rotate(
                  angle: onboardingCubit.completedFirstAnimation ? 6.58 : 0,
                  child: SvgPicture.string(
                    SVGStrings.greenCircleFill,
                    height: 69.33.h,
                    width: 69.33.w,
                    colorFilter: colorFilter,
                  ),
                );
              },
            ),
            if (onboardingCubit.completedFirstAnimation)
              Transform.rotate(
                angle: 3.3,
                alignment: Alignment.center,
                child: OnboardingCircleGreenSmallWidget(
                  color: onboardingCubit.onEndAnimatedColor(AppColors.green),
                ),
              ),
          ],
        ),
      ),
      crossFadeState: onboardingCubit.isAnimationHasStarted
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(
        milliseconds: NumConstants.animationDuration,
      ),
    );
  }

  ColorFilter? get colorFilter {
    if (!onboardingCubit.completedFirstAnimation) return null;
    return ColorFilter.mode(
      onboardingCubit.onStartAnimatedColor(AppColors.green),
      BlendMode.srcIn,
    );
  }
}

class OnboardingCircleGreenSmallWidget extends StatelessWidget {
  const OnboardingCircleGreenSmallWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(69.33.w, (69.33.w * 1.0142857142857142).toDouble()),
      painter: OnboardingCircleGreenSmallCustomPainter(),
    );
  }
}
