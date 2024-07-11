import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/num_constants.dart';
import '../../onboarding/onboarding_home_view.dart';

class ColaCircleGreenWithHero extends StatelessWidget {
  const ColaCircleGreenWithHero({
    super.key,
    required this.curvedAnimationSlider,
    required this.onboardingHeroTags,
    required this.height,
    required this.width,
    required this.opacityColaCircle,
  });

  final CurvedAnimation curvedAnimationSlider;
  final OnboardingHeroTags onboardingHeroTags;
  final double height;
  final double width;
  final ValueNotifier<double> opacityColaCircle;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: Offset(-1.9, -2.9.h),
      ).animate(curvedAnimationSlider),
      child: Hero(
        tag: onboardingHeroTags.colaCircleTag,
        flightShuttleBuilder: (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
        ) {
          final customAnimation = Tween<double>(
            begin: 0,
            end: 2,
          ).animate(animation);
          return AnimatedBuilder(
            animation: customAnimation,
            builder: (context, child) {
              bool startSwitch = customAnimation.value > 0.0859375 ? true : false;

              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: NumConstants.duration800,
                ),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  key: ValueKey(startSwitch),
                  height: height / 10.5,
                  width: width / 10.5,
                  startSwitch
                      ? ImagesConstants.onboardingCircleBorderGreen
                      : ImagesConstants.ellipseGreen,
                ),
              );
            },
          );
        },
        child: ValueListenableBuilder(
          valueListenable: opacityColaCircle,
          builder: (context, value, child) {
            return AnimatedOpacity(
              opacity: value,
              duration: const Duration(seconds: 1),
              child: SvgPicture.asset(
                height: 82.981.h,
                width: 82.981.w,
                ImagesConstants.ellipseGreen,
              ),
            );
          },
        ),
      ),
    );
  }
}
