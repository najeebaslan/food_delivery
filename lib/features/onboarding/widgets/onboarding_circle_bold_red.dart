import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widget/custom_painters/onboarding_circle_bold_red_custom_painter.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class OnboardingCircleBoldRed extends StatelessWidget {
  const OnboardingCircleBoldRed({
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
              duration: const Duration(milliseconds: NumConstants.animationDuration),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateZ(transformZ),
                child: onboardingCubit.completedFirstAnimation == false
                    ? FirstCircleBoldRedAnimation(
                        onboardingHeroTags: onboardingHeroTags,
                        onboardingCubit: onboardingCubit,
                      )
                    : LastCircleBoldRedAnimation(
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

class FirstCircleBoldRedAnimation extends StatelessWidget {
  const FirstCircleBoldRedAnimation({
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
              const OnboardingCircleBoldRedWidget(),
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
                        onboardingCubit.onStartAnimatedColor(AppColors.red),
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
      crossFadeState: onboardingCubit.isAnimationHasStarted
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(
        milliseconds: NumConstants.animationDuration,
      ),
    );
  }
}

class LastCircleBoldRedAnimation extends StatelessWidget {
  const LastCircleBoldRedAnimation({
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
              OnboardingCircleBoldRedWidget(
                color: onboardingCubit.onStartAnimatedColor(AppColors.red),
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
                        onboardingCubit.onEndAnimatedColor(AppColors.red),
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
      crossFadeState: onboardingCubit.isAnimationHasStarted
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(
        milliseconds: NumConstants.animationDuration,
      ),
    );
  }
}

class OnboardingCircleBoldRedWidget extends StatelessWidget {
  const OnboardingCircleBoldRedWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        72.33.w,
        (72.33.w * 1.0142857142857142).toDouble(),
      ),
      painter: OnboardingCircleBoldRedCustomPainter(color: color),
    );
  }
}
