import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/widget/custom_painters/onboarding_circle_bold_red_custom_painter.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class TestAnimation extends StatefulWidget {
  const TestAnimation({super.key});

  @override
  State<TestAnimation> createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late OnboardingCubit onboardingCubit;
  late Tween<double> animation;
  late Tween<double> firstColorTweenAnimation;
  late Tween<double> firstColorTweenAnimation1;
  bool isStartAnimation = false;
  @override
  void initState() {
    super.initState();
    onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: NumConstants.animationDuration,
      ),
    );
    initAnimation();
  }

  bool completedFirstAnimation = false;
  double topPositionedCircleYellow = 130.h;
  double rightPositionedCircleYellow = 290.w;

  void initAnimation() {
    animation = Tween<double>(begin: 0, end: 1);
    // topPositionedCircleRed = 180.h;
    // leftPositionedCircleRed = -10.w;

    // topPositionedCircleGreen = 130.h;
    // leftPositionedCircleGreen = 250.w;

    // topPositionedCircleYellow = 280.h;
    // leftPositionedCircleYellow = 290.w;

    // animationController.forward();
    // firstColorTweenAnimation = Tween<double>(begin: 0.9, end: 0.0);
    // emit(InitAnimationOnboarding());
    // statusListenerAnimation();

    Future.delayed(Duration(seconds: 2), () {
      topPositionedCircleYellow = 180.h;
      rightPositionedCircleYellow = 290.w;
      isStartAnimation = true;
      firstColorTweenAnimation = Tween<double>(begin: 0.0, end: 1);
      firstColorTweenAnimation1 = Tween<double>(begin: 0.6, end: 0.0);

      _animationController.forward();
      statusListenerAnimation();
    });
    // Future.delayed(Duration(seconds: 4), () {

    //   setState(() {

    //   });
    // });
  }

  void statusListenerAnimation() {
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: NumConstants.animationDuration), () {
          if (completedFirstAnimation == false) {
            _animationController
              ..reset()
              ..forward();

            // topPositionedCircleRed = 80.h;
            // leftPositionedCircleRed = 50.w;

            // topPositionedCircleGreen = 250.h;
            // leftPositionedCircleGreen = 290.w;

            topPositionedCircleYellow = 430.h;
            rightPositionedCircleYellow = -5.w;

            // lastColorTweenAnimation = Tween<double>(begin: 0.0, end: 1);
            completedFirstAnimation = true;
            // emit(CompletedFirstAnimationOnboarding());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                log(isStartAnimation.toString());
                return AnimatedPositioned(
                  duration: Duration(
                    milliseconds: NumConstants.animationDuration,
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
                        SvgPicture.asset(
                          ImagesConstants.onboardingCircleBorderYellow,
                          height: 84.33.h,
                          width: 84.33.w,
                          colorFilter: isStartAnimation
                              ? ColorFilter.mode(
                                  AppColors.yellow.withOpacity(
                                    isStartAnimation
                                        ? firstColorTweenAnimation1
                                            .evaluate(_animationController)
                                        : 0,
                                  ),
                                  BlendMode.srcIn,
                                )
                              : null,
                        ),
                        OnboardingCircleBoldRedWidget(
                          color: AppColors.yellow.withOpacity(
                            isStartAnimation ? _animationController.value : 0,
                          ),
                        ),
                      ],
                    ),
                    // AnimatedCrossFade(
                    //   firstChild: Stack(
                    //     children: [
                    //       SvgPicture.asset(
                    //         ImagesConstants.onboardingCircleBorderYellow,
                    //         height: 84.33.h,
                    //         width: 84.33.w,
                    //       ),
                    //       OnboardingCircleBoldRedWidget(
                    //         color: AppColors.yellow.withOpacity(
                    //           isStartAnimation
                    //               ? firstColorTweenAnimation
                    //                   .evaluate(_animationController)
                    //               : 0,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    //   secondChild: Transform.rotate(
                    //     angle: 0.1,
                    //     child: OnboardingCircleBoldRedWidget(
                    //       color: AppColors.yellow,
                    //     ),
                    //     //   SvgPicture.string(
                    //     //     '''<svg width="86" height="84" viewBox="0 0 86 84" fill="none" xmlns="http://www.w3.org/2000/svg">
                    //     // <path d="M52.11 5.31002C52.9021 2.08611 56.1812 0.0754883 59.2611 1.31463C66.9533 4.4095 73.6155 9.70913 78.3705 16.6082C84.2693 25.1666 86.8234 35.5916 85.5488 45.9074C84.2741 56.2232 79.2594 65.7131 71.4549 72.5783C63.6505 79.4435 53.5986 83.2071 43.2045 83.1557C32.8103 83.1044 22.7961 79.2417 15.0599 72.2997C7.32364 65.3577 2.4029 55.8188 1.23027 45.4909C0.0576327 35.1629 2.7146 24.7637 8.6976 16.264C13.5206 9.41224 20.2348 4.1787 27.9572 1.15999C31.0492 -0.0486666 34.3082 1.99425 35.0685 5.22583C35.8287 8.45741 33.7865 11.6411 30.767 13.0207C25.8907 15.2488 21.6551 18.742 18.5284 23.184C14.2396 29.2768 12.335 36.7313 13.1756 44.1346C14.0162 51.5379 17.5435 58.3757 23.089 63.3519C28.6346 68.3281 35.813 71.097 43.2639 71.1338C50.7147 71.1706 57.9201 68.4728 63.5146 63.5516C69.109 58.6304 72.7037 51.8279 73.6174 44.4332C74.5311 37.0385 72.7003 29.5656 68.4719 23.4307C65.3892 18.958 61.1883 15.4231 56.3343 13.147C53.3285 11.7376 51.3179 8.53393 52.11 5.31002Z" fill="#FABB2D"/>
                    //     // </svg>
                    //     // ''',
                    //     //     // ImagesConstants.onboardingCircleBorderYellow,
                    //     //     height: 84.33.h,
                    //     //     width: 84.33.w,
                    //     //   ),
                    //   ),
                    //   crossFadeState: isStartAnimation
                    //       ? CrossFadeState.showSecond
                    //       : CrossFadeState.showFirst,
                    //   duration: Duration(
                    //     milliseconds: NumConstants.animationDuration,
                    //   ),
                    // ),
                  ),
                );
              })
        ],
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
        84.33.w,
        (84.33.w * 1.0142857142857142).toDouble(),
      ),
      painter: OnboardingCircleBoldRedCustomPainter(color: color),
    );
  }
}
