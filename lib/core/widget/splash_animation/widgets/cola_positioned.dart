import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../features/onboarding/onboarding_home_view.dart';
import '../../../constants/assets_constants.dart';
import '../../../constants/num_constants.dart';

class ColaPositioned extends StatelessWidget {
  const ColaPositioned({
    super.key,
    required this.height,
    required this.positionAnimationCola,
    required this.onboardingHeroTags,
    required this.width,
    required this.opacityColaCircle,
  });

  final double height;
  final Animation<Offset> positionAnimationCola;
  final OnboardingHeroTags onboardingHeroTags;
  final double width;
  final ValueNotifier<double> opacityColaCircle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height / 6.4,
      left: 0.w,
      child: SlideTransition(
        position: positionAnimationCola,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Hero(
                tag: onboardingHeroTags.colaCircleTag,
                flightShuttleBuilder: (
                  flightContext,
                  animation,
                  flightDirection,
                  fromHeroContext,
                  toHeroContext,
                ) {
                  final customAnimation =
                      Tween<double>(begin: 0, end: 2).animate(animation);
                  return AnimatedBuilder(
                    animation: customAnimation,
                    builder: (context, child) {
                      bool startSwitch = customAnimation.value > 0.0859375 ? true : false;

                      return AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: NumConstants.animationDuration,
                        ),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: SvgPicture.asset(
                          key: ValueKey(startSwitch),
                          height: (height / 10.5),
                          width: (width / 10.5),
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
                        height: (height / 10.5),
                        width: (width / 10.5),
                        ImagesConstants.ellipseGreen,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: (height * -0.10),
              left: -40,
              child: Image.asset(
                ImagesConstants.colaIsometric,
                height: (height / 4),
                width: (width / 1.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
