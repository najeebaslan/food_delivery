import 'dart:math' as math;

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

class CircleYellow extends StatefulWidget {
  const CircleYellow({super.key});

  @override
  State<CircleYellow> createState() => _CircleYellowState();
}

class _CircleYellowState extends State<CircleYellow> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late OnboardingCubit onboardingCubit;
  late Tween<double> animation;
  late Tween<double> firstColorTweenAnimation;
  bool isStartAnimation = false;
  @override
  void initState() {
    super.initState();
    onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: NumConstants.animationDuration - 100,
      ),
    );
    initAnimation();
  }

  bool completedFirstAnimation = false;
  double topPositionedCircleYellow = 130.h;
  double rightPositionedCircleYellow = 290.w;

  void initAnimation() {
    animation = Tween<double>(begin: 0, end: 1);

    Future.delayed(Duration(seconds: 2), () {
      topPositionedCircleYellow = 280.h;
      rightPositionedCircleYellow = 290.w;
      isStartAnimation = true;
      firstColorTweenAnimation = Tween<double>(begin: 0, end: math.pi / 1.5);

      _animationController.forward();
      statusListenerAnimation();
    });
  }

  void statusListenerAnimation() {
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(
            Duration(milliseconds: NumConstants.animationDuration),
            () {
              if (completedFirstAnimation == false) {
                completedFirstAnimation = true;

                _animationController
                  ..reset()
                  ..forward();

                topPositionedCircleYellow = 430.h;
                rightPositionedCircleYellow = -5.w;
              }
            },
          );
        }
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
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
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
                    Transform.rotate(
                      angle: 5.3,
                      child: SvgPicture.asset(
                        ImagesConstants.onboardingCircleBoldYellow,
                        height: 84.33.h,
                        width: 84.33.w,
                        colorFilter: ColorFilter.mode(
                          completedFirstAnimation
                              ? AppColors.yellow
                              : (isStartAnimation == false)
                                  ? AppColors.white
                                  : AppColors.yellow.withOpacity(
                                      _animationController.value,
                                    ),
                          
                          BlendMode.srcIn,
                        ),
                      ),
                      // OnboardingCircleBoldRedWidget(
                      //   color: AppColors.yellow.withOpacity(
                      //     completedFirstAnimation
                      //         ? 1.0
                      //         : isStartAnimation
                      //             ? _animationController.value
                      //             : 0,
                      //   ),
                      // ),
                    ),
                    SvgPicture.asset(
                      ImagesConstants.onboardingCircleBorderYellow,
                      height: 84.33.h,
                      width: 84.33.w,
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
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
      painter: RPSCustomPainter(color: color),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  final Color? color;
  RPSCustomPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6059302, size.height * 0.06321452);
    path_0.cubicTo(
        size.width * 0.6151407,
        size.height * 0.02483464,
        size.width * 0.6532698,
        size.height * 0.0008986702,
        size.width * 0.6890826,
        size.height * 0.01565036);
    path_0.cubicTo(
        size.width * 0.7785267,
        size.height * 0.05249405,
        size.width * 0.8559942,
        size.height * 0.1155849,
        size.width * 0.9112849,
        size.height * 0.1977167);
    path_0.cubicTo(size.width * 0.9798756, size.height * 0.2996024, size.width * 1.009574,
        size.height * 0.4237095, size.width * 0.9947535, size.height * 0.5465167);
    path_0.cubicTo(
        size.width * 0.9799314,
        size.height * 0.6693238,
        size.width * 0.9216209,
        size.height * 0.7822988,
        size.width * 0.8308709,
        size.height * 0.8640274);
    path_0.cubicTo(
        size.width * 0.7401221,
        size.height * 0.9457560,
        size.width * 0.6232395,
        size.height * 0.9905607,
        size.width * 0.5023779,
        size.height * 0.9899488);
    path_0.cubicTo(
        size.width * 0.3815151,
        size.height * 0.9893381,
        size.width * 0.2650709,
        size.height * 0.9433536,
        size.width * 0.1751151,
        size.height * 0.8607107);
    path_0.cubicTo(
        size.width * 0.08515860,
        size.height * 0.7780679,
        size.width * 0.02794070,
        size.height * 0.6645095,
        size.width * 0.01430547,
        size.height * 0.5415583);
    path_0.cubicTo(
        size.width * 0.0006701477,
        size.height * 0.4186060,
        size.width * 0.03156512,
        size.height * 0.2948060,
        size.width * 0.1011349,
        size.height * 0.1936190);
    path_0.cubicTo(
        size.width * 0.1572163,
        size.height * 0.1120505,
        size.width * 0.2352884,
        size.height * 0.04974643,
        size.width * 0.3250837,
        size.height * 0.01380940);
    path_0.cubicTo(
        size.width * 0.3610372,
        size.height * -0.0005793643,
        size.width * 0.3989326,
        size.height * 0.02374107,
        size.width * 0.4077733,
        size.height * 0.06221226);
    path_0.cubicTo(
        size.width * 0.4166128,
        size.height * 0.1006835,
        size.width * 0.3928663,
        size.height * 0.1385845,
        size.width * 0.3577558,
        size.height * 0.1550083);
    path_0.cubicTo(
        size.width * 0.3010547,
        size.height * 0.1815333,
        size.width * 0.2518035,
        size.height * 0.2231190,
        size.width * 0.2154465,
        size.height * 0.2760000);
    path_0.cubicTo(
        size.width * 0.1655767,
        size.height * 0.3485333,
        size.width * 0.1434302,
        size.height * 0.4372774,
        size.width * 0.1532047,
        size.height * 0.5254119);
    path_0.cubicTo(
        size.width * 0.1629791,
        size.height * 0.6135464,
        size.width * 0.2039942,
        size.height * 0.6949488,
        size.width * 0.2684767,
        size.height * 0.7541893);
    path_0.cubicTo(
        size.width * 0.3329605,
        size.height * 0.8134298,
        size.width * 0.4164302,
        size.height * 0.8463929,
        size.width * 0.5030686,
        size.height * 0.8468310);
    path_0.cubicTo(
        size.width * 0.5897058,
        size.height * 0.8472690,
        size.width * 0.6734895,
        size.height * 0.8151524,
        size.width * 0.7385419,
        size.height * 0.7565667);
    path_0.cubicTo(
        size.width * 0.8035930,
        size.height * 0.6979810,
        size.width * 0.8453919,
        size.height * 0.6169988,
        size.width * 0.8560163,
        size.height * 0.5289667);
    path_0.cubicTo(
        size.width * 0.8666407,
        size.height * 0.4409345,
        size.width * 0.8453523,
        size.height * 0.3519714,
        size.width * 0.7961849,
        size.height * 0.2789369);
    path_0.cubicTo(
        size.width * 0.7603395,
        size.height * 0.2256905,
        size.width * 0.7114919,
        size.height * 0.1836083,
        size.width * 0.6550500,
        size.height * 0.1565119);
    path_0.cubicTo(
        size.width * 0.6200988,
        size.height * 0.1397333,
        size.width * 0.5967198,
        size.height * 0.1015944,
        size.width * 0.6059302,
        size.height * 0.06321452);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color ?? AppColors.yellow;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
