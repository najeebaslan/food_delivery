import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widget/custom_painters/onboarding_circle_green_small_custom_painter.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class CircleGreen extends StatelessWidget {
  const CircleGreen({
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
              duration: Duration(milliseconds: NumConstants.animationDuration),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(onboardingCubit.completedFirstAnimation == false
                      ? transformZ / 2
                      : -(transformZ / 1)),
                child: onboardingCubit.completedFirstAnimation == false
                    ? FirstCircleGreenAnimation(
                        onboardingHeroTags: onboardingHeroTags,
                        onboardingCubit: onboardingCubit,
                      )
                    : LastCircleGreenAnimation(
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
    if (onboardingCubit.isStartAnimation == false) return 0;

    return onboardingCubit.animation.evaluate(
      onboardingCubit.animationController,
    );
  }
}

class FirstCircleGreenAnimation extends StatelessWidget {
  const FirstCircleGreenAnimation({
    super.key,
    required this.onboardingHeroTags,
    required this.onboardingCubit,
  });

  final String onboardingHeroTags;
  final OnboardingCubit onboardingCubit;
  static String GreenCircleFill =
      '''<svg width="57" height="57" viewBox="0 0 57 57" fill="none" xmlns="http://www.w3.org/2000/svg">
<path opacity="0.9" d="M19.8449 7.19166C18.7318 4.39277 20.0996 1.16355 23.0605 0.610533C27.9669 -0.305841 33.0635 0.0937915 37.8172 1.8176C44.2926 4.16577 49.6816 8.80789 52.9628 14.8642C56.244 20.9205 57.1894 27.97 55.6199 34.6769C54.0503 41.3837 50.0749 47.2817 44.447 51.253C38.8191 55.2244 31.9298 56.9931 25.0849 56.2241C18.2399 55.455 11.9149 52.2015 7.30865 47.0802C2.70238 41.959 0.134908 35.3259 0.0928427 28.438C0.0619606 23.3815 1.39362 18.4457 3.90141 14.1302C5.41481 11.5259 8.91569 11.3195 11.1796 13.3063C15.4867 17.0862 21.9626 12.5165 19.8449 7.19166Z" fill="#3AA856"/>
</svg>
''';
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
                  return SvgPicture.string(
                    GreenCircleFill,
                    height: 69.33.h,
                    width: 69.33.w,
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

class LastCircleGreenAnimation extends StatelessWidget {
  const LastCircleGreenAnimation({
    super.key,
    required this.onboardingHeroTags,
    required this.onboardingCubit,
  });

  final String onboardingHeroTags;
  final OnboardingCubit onboardingCubit;
  static String GreenCircle =
      '''<svg width="57" height="57" viewBox="0 0 57 57" fill="none" xmlns="http://www.w3.org/2000/svg">
<path opacity="0.9" d="M19.8449 7.19166C18.7318 4.39277 20.0996 1.16355 23.0605 0.610533C27.9669 -0.305841 33.0635 0.0937915 37.8172 1.8176C44.2926 4.16577 49.6816 8.80789 52.9628 14.8642C56.244 20.9205 57.1894 27.97 55.6199 34.6769C54.0503 41.3837 50.0749 47.2817 44.447 51.253C38.8191 55.2244 31.9298 56.9931 25.0849 56.2241C18.2399 55.455 11.9149 52.2015 7.30865 47.0802C2.70238 41.959 0.134908 35.3259 0.0928427 28.438C0.0619606 23.3815 1.39362 18.4457 3.90141 14.1302C5.41481 11.5259 8.91569 11.3195 11.1796 13.3063C15.4867 17.0862 21.9626 12.5165 19.8449 7.19166Z" fill="#3AA856"/>
</svg>
''';

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
          angle: 2,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              OnboardingCircleGreenSmallWidget(),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (previous, current) =>
                    current is CompletedFirstAnimationOnboarding,
                builder: (context, state) {
                  return Transform.rotate(
                    angle: 3.3,
                    alignment: Alignment.center,
                    child: SvgPicture.string(
                      GreenCircle,
                      height: 69.33.h,
                      width: 69.33.w,
                      colorFilter: ColorFilter.mode(
                        onboardingCubit.onStartAnimatedColor(AppColors.green),
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

class OnboardingCircleGreenSmallWidget extends StatelessWidget {
  const OnboardingCircleGreenSmallWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        72.33.w,
        (72.33.w * 1.0142857142857142).toDouble(),
      ),
      painter: OnboardingCircleGreenSmallCustomPainter(),
    );
  }
}
