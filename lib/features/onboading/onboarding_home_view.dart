import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/num_constants.dart';
import '../../core/widget/custom_painters/onboarding_circle_bold_red.dart';
import 'widgets/body_onboarding.dart';

class OnboardingHomeView extends StatefulWidget {
  const OnboardingHomeView({super.key, required this.onboardingHeroTags});
  final OnboardingHeroTags onboardingHeroTags;

  @override
  State<OnboardingHomeView> createState() => _OnboardingHomeViewState();
}

class _OnboardingHomeViewState extends State<OnboardingHomeView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late Tween<double> _animation;
  final _delayTimeStartAnimation = ValueNotifier<bool>(false);

  static List<String> title = [
    'Fastest Food delivery',
    'Good Food for Good Moments',
    'Good food smile',
  ];
  static List<String> subtitle = [
    'Want a delicious meal, but no\n time we will deliver it hot and yummy.',
    'Taste that best, its on time.',
    'Want a delicious meal, but no\n time we will deliver it hot and yummy.',
  ];
  late Tween<double> _colorTween;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(
        milliseconds: NumConstants.animationDurationTime,
      ),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 2),
      () {
        _animation = Tween<double>(begin: 0, end: math.pi / 1.5);
        _delayTimeStartAnimation.value = true;
        _animationController.forward();
        _colorTween = Tween<double>(begin: 0.5, end: 0.0);
        _animationController.addListener(() {});
        _animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {}
        });
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
    return PlatformScaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: 20.w,
          left: 20.w,
        ),
        child: ValueListenableBuilder(
          valueListenable: _delayTimeStartAnimation,
          builder: (context, isStart, child) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 180.h,
                  child: SizedBox(
                    height: 331.h,
                    width: 331.w,
                    child: Image.asset(
                      ImagesConstants.deliveryManOnboarding,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 100.h,
                  child: Hero(
                    tag: widget.onboardingHeroTags.colaCircleTag,
                    child: SvgPicture.asset(
                      ImagesConstants.circleBorderGreen,
                      height: 56.27.h,
                      width: 56.27.w,
                    ),
                  ),
                ),
                Positioned(
                  top: 130.h,
                  right: 20.w,
                  child: SvgPicture.asset(
                    ImagesConstants.circleBorderYellow,
                  ),
                ),
                AnimatedPositioned(
                  top: isStart ? 190.h : 340.h,
                  left: isStart ? -10.w : 20.w,
                  duration: Duration(milliseconds: NumConstants.animationDurationTime),
                  child: AnimatedBuilder(
                    animation: Listenable.merge([_animationController]),
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ(
                            isStart ? _animation.evaluate(_animationController) : 0,
                          ),
                        child: AnimatedCrossFade(
                          firstChild: Hero(
                            tag: widget.onboardingHeroTags.drinkTag,
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
                                  OnboardingCircleBoldRed(),
                                  Transform.rotate(
                                    angle: 2.1,
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      ImagesConstants.onboardingCircleRed,
                                      height: 69.33.h,
                                      width: 69.33.w,
                                      colorFilter: ColorFilter.mode(
                                        Color(0xFFE8453C).withOpacity(
                                          isStart
                                              ? _colorTween.evaluate(_animationController)
                                              : 0,
                                        ),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          crossFadeState: isStart
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(
                            milliseconds: NumConstants.animationDurationTime,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 130.h,
                  child: BodyOnboardingHome(
                    title: title,
                    subtitle: subtitle,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class OnboardingHeroTags {
  final String drinkTag;
  final String colaCircleTag;
  OnboardingHeroTags({
    required this.drinkTag,
    required this.colaCircleTag,
  });
}
