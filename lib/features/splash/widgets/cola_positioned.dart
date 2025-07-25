import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/hero_tags_constants.dart';
import '../../../core/constants/num_constants.dart';

class ColaCircleGreenWithHero extends StatelessWidget {
  const ColaCircleGreenWithHero({
    super.key,
    required this.curvedAnimationSlider,
    required this.opacityColaCircle,
    required this.height,
    required this.width,
  });

  final CurvedAnimation curvedAnimationSlider;
  final ValueNotifier<double> opacityColaCircle;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: Offset(-1.9, -2.9.h),
      ).animate(curvedAnimationSlider),
      child: Hero(
        tag: HeroTagsConstants.colaCircleTagOnboardingView,
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
