import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class CircleYellow extends StatelessWidget {
  const CircleYellow({
    super.key,
    required this.onboardingCubit,
  });

  final OnboardingCubit onboardingCubit;
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
              top: onboardingCubit.topPositionedCircleYellow,
              // left: onboardingCubit.leftPositionedCircleYellow,
              left: onboardingCubit.completedFirstAnimation == true
                  ? onboardingCubit.leftPositionedCircleYellow
                  : (MediaQuery.sizeOf(context).width / 1.5),
              duration: Duration(milliseconds: NumConstants.animationDuration),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(onboardingCubit.completedFirstAnimation == false
                      ? transformZ
                      : -(transformZ / 1)),
                child: Transform.rotate(
                  angle: onboardingCubit.isStartAnimation ? 11.5 : 0,
                  child:
                      //  FirstCircleYellowAnimation(
                      //   onboardingCubit: onboardingCubit,
                      // ),
                      // )
                      onboardingCubit.completedFirstAnimation == false
                          ? SvgPicture.asset(
                              ImagesConstants.onboardingCircleBorderYellow,
                              height: 84.33.h,
                              width: 84.33.w,
                            )
                          // FirstCircleYellowAnimation(
                          //     onboardingCubit: onboardingCubit,
                          //   )
                          : LastCircleYellowAnimation(
                              onboardingCubit: onboardingCubit,
                            ),
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

class FirstCircleYellowAnimation extends StatelessWidget {
  const FirstCircleYellowAnimation({
    super.key,
    required this.onboardingCubit,
  });

  final OnboardingCubit onboardingCubit;
  static String yellowCircleFill =
      '''<svg width="86" height="84" viewBox="0 0 86 84" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M52.11 5.31002C52.9021 2.08611 56.1812 0.0754883 59.2611 1.31463C66.9533 4.4095 73.6155 9.70913 78.3705 16.6082C84.2693 25.1666 86.8234 35.5916 85.5488 45.9074C84.2741 56.2232 79.2594 65.7131 71.4549 72.5783C63.6505 79.4435 53.5986 83.2071 43.2045 83.1557C32.8103 83.1044 22.7961 79.2417 15.0599 72.2997C7.32364 65.3577 2.4029 55.8188 1.23027 45.4909C0.0576327 35.1629 2.7146 24.7637 8.6976 16.264C13.5206 9.41224 20.2348 4.1787 27.9572 1.15999C31.0492 -0.0486666 34.3082 1.99425 35.0685 5.22583C35.8287 8.45741 33.7865 11.6411 30.767 13.0207C25.8907 15.2488 21.6551 18.742 18.5284 23.184C14.2396 29.2768 12.335 36.7313 13.1756 44.1346C14.0162 51.5379 17.5435 58.3757 23.089 63.3519C28.6346 68.3281 35.813 71.097 43.2639 71.1338C50.7147 71.1706 57.9201 68.4728 63.5146 63.5516C69.109 58.6304 72.7037 51.8279 73.6174 44.4332C74.5311 37.0385 72.7003 29.5656 68.4719 23.4307C65.3892 18.958 61.1883 15.4231 56.3343 13.147C53.3285 11.7376 51.3179 8.53393 52.11 5.31002Z" fill="#FABB2D"/>
</svg>
''';
  static String yellowCircle =
      '''<svg width="86" height="84" viewBox="0 0 86 84" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M52.11 5.31002C52.9021 2.08611 56.1812 0.0754883 59.2611 1.31463C66.9533 4.4095 73.6155 9.70913 78.3705 16.6082C84.2693 25.1666 86.8234 35.5916 85.5488 45.9074C84.2741 56.2232 79.2594 65.7131 71.4549 72.5783C63.6505 79.4435 53.5986 83.2071 43.2045 83.1557C32.8103 83.1044 22.7961 79.2417 15.0599 72.2997C7.32364 65.3577 2.4029 55.8188 1.23027 45.4909C0.0576327 35.1629 2.7146 24.7637 8.6976 16.264C13.5206 9.41224 20.2348 4.1787 27.9572 1.15999C31.0492 -0.0486666 34.3082 1.99425 35.0685 5.22583C35.8287 8.45741 33.7865 11.6411 30.767 13.0207C25.8907 15.2488 21.6551 18.742 18.5284 23.184C14.2396 29.2768 12.335 36.7313 13.1756 44.1346C14.0162 51.5379 17.5435 58.3757 23.089 63.3519C28.6346 68.3281 35.813 71.097 43.2639 71.1338C50.7147 71.1706 57.9201 68.4728 63.5146 63.5516C69.109 58.6304 72.7037 51.8279 73.6174 44.4332C74.5311 37.0385 72.7003 29.5656 68.4719 23.4307C65.3892 18.958 61.1883 15.4231 56.3343 13.147C53.3285 11.7376 51.3179 8.53393 52.11 5.31002Z" fill="#FABB2D"/>
</svg>
''';
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Hero(
        tag: 'onboardingHeroTags',
        child: SvgPicture.asset(
          ImagesConstants.onboardingCircleBorderYellow,
          height: 84.33.h,
          width: 84.33.w,
        ),
      ),
      secondChild: Transform.rotate(
          alignment: Alignment.center,
          angle: 5,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // BlocBuilder<OnboardingCubit, OnboardingState>(
              //   buildWhen: (previous, current) =>
              //       current is CompletedFirstAnimationOnboarding,
              //   builder: (context, state) {
              //     return SvgPicture.string(
              //       yellowCircle,
              //       height: 84.33.h,
              //       width: 84.33.w,
              //     );
              //   },
              // ),

              // SvgPicture.string(
              //   yellowCircle,
              //   height: 84.33.h,
              //   width: 84.33.w,
              // ),
              // OnboardingCircleGreenSmallWidget(),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (previous, current) =>
                    current is CompletedFirstAnimationOnboarding,
                builder: (context, state) {
                  return Transform.rotate(
                    angle: 11.3,
                    alignment: Alignment.center,
                    child: SvgPicture.string(
                      yellowCircle,
                      height: 84.33.h,
                      width: 84.33.w,
                      colorFilter: ColorFilter.mode(
                        onboardingCubit.onStartAnimatedColor(AppColors.yellow),
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

class LastCircleYellowAnimation extends StatelessWidget {
  const LastCircleYellowAnimation({
    super.key,
    required this.onboardingCubit,
  });

  final OnboardingCubit onboardingCubit;
  static String yellowCircle =
      '''<svg width="86" height="84" viewBox="0 0 86 84" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M30.1137 75.6265C28.6524 79.3825 24.3776 81.2935 20.9269 79.2112C14.2056 75.1553 8.69669 69.2871 5.07466 62.2154C0.336244 52.964 -0.843612 42.2957 1.75871 32.2325C4.36103 22.1692 10.5647 13.4103 19.1939 7.61572C27.8232 1.82115 38.2784 -0.606398 48.578 0.793157C58.8776 2.19271 68.306 7.32211 75.0761 15.2092C81.8462 23.0963 85.4877 33.193 85.3104 43.5858C85.1331 53.9786 81.1492 63.9452 74.114 71.5967C68.7363 77.4455 61.8612 81.631 54.3013 83.7463C50.4202 84.8323 46.8103 81.8499 46.4042 77.8401C45.9981 73.8304 48.9831 70.3382 52.7508 68.9075C56.771 67.381 60.4151 64.9324 63.3703 61.7184C67.9871 56.6972 70.6013 50.1568 70.7177 43.3368C70.8341 36.5168 68.4444 29.891 64.0017 24.7153C59.5589 19.5395 53.3718 16.1735 46.6129 15.255C39.854 14.3366 32.993 15.9296 27.3302 19.7322C21.6674 23.5348 17.5964 29.2826 15.8887 35.8864C14.181 42.4902 14.9552 49.491 18.0647 55.5621C20.0551 59.4481 22.9137 62.7804 26.3808 65.3242C29.6302 67.7084 31.575 71.8706 30.1137 75.6265Z" fill="#FABB2D"/>
</svg>
''';
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Hero(
        tag: 'onboardingHeroTags1',
        child: SvgPicture.asset(
          ImagesConstants.onboardingCircleBorderGreen,
          height: 84.33.h,
          width: 84.33.w,
        ),
      ),
      secondChild: Transform.rotate(
          alignment: Alignment.center,
          angle: 3,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              SvgPicture.string(
                yellowCircle,
                height: 84.33.h,
                width: 84.33.w,
              ),
              // OnboardingCircleGreenSmallWidget(),
              // BlocBuilder<OnboardingCubit, OnboardingState>(
              //   buildWhen: (previous, current) =>
              //       current is CompletedFirstAnimationOnboarding,
              //   builder: (context, state) {
              //     return Transform.rotate(
              //       angle: 3.3,
              //       alignment: Alignment.center,
              //       child: SvgPicture.string(
              //         yellowCircle,
              //         height: 69.33.h,
              //         width: 69.33.w,
              //         colorFilter: ColorFilter.mode(
              //           onboardingCubit.onStartAnimatedColor(AppColors.yellow),
              //           BlendMode.srcIn,
              //         ),
              //       ),
              //     );
              //   },
              // ),
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

// class OnboardingCircleYellowWidget extends StatelessWidget {
//   const OnboardingCircleYellowWidget({super.key, this.color});
//   final Color? color;
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(
//         72.33.w,
//         (72.33.w * 1.0142857142857142).toDouble(),
//       ),
//       painter: OnboardingCircleYellowCustomPainter(color: color),
//     );
//   }
// }
