import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/assets_constants.dart';
import '../core/styles/color_hex.dart';

class SplashAnimationView extends StatefulWidget {
  const SplashAnimationView({super.key});

  @override
  State<SplashAnimationView> createState() => _SplashAnimationViewState();
}

class _SplashAnimationViewState extends State<SplashAnimationView>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation animation;
  final ValueNotifier<double> _opacityColaCircle = ValueNotifier<double>(0.0);
  final ValueNotifier<double> _opacityEllipseSmall = ValueNotifier<double>(0.0);

  late final Animation<Offset> _positionAnimation = Tween<Offset>(
    begin: Offset(0.0, 1.5.h),
    end: Offset(-0.0, .2.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );

  late final Animation<Offset> _positionAnimationCola = Tween<Offset>(
    begin: Offset(1.0, 3.5.h),
    end: Offset(0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );

  late final Animation<Offset> _positionAnimationHotDog = Tween<Offset>(
    begin: Offset(-.7, 2.5.h),
    end: Offset(0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );
  late final Animation<Offset> _positionAnimationMayo = Tween<Offset>(
    begin: Offset(.5, 1.h),
    end: Offset(0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );

  late final Animation<Offset> _positionAnimationBurger = Tween<Offset>(
    begin: Offset(-.5, -0.6.h),
    end: Offset(0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );
  late final Animation<Offset> _positionAnimationTridonut = Tween<Offset>(
    begin: Offset(.5, -1.5.h),
    end: Offset(0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        _opacityColaCircle.value = 0.9;
        _opacityEllipseSmall.value = 0.9;
      },
    );
    animationController.forward().whenComplete(() {
      return Future.delayed(const Duration(milliseconds: 100), () async {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, AppRoutesConstants.OnboardingHomeView, (route) => false);
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            return Center(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                fit: StackFit.loose,
                children: [
                  // Hot dog isometric
                  Positioned(
                    top: 100.h,
                    right: 0.w,
                    child: SlideTransition(
                      position: _positionAnimationHotDog,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SvgPicture.asset(
                            height: (height / 6.5),
                            width: (width / 6.5),
                            ImagesConstants.ellipseYellow,
                          ),
                          Positioned(
                            bottom: -10.h,
                            child: Image.asset(
                              height: (height / 5.1),
                              width: (width / 2.2),
                              ImagesConstants.hotDogIsometric,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Mayo isometric
                  Positioned(
                    top: height / 5,
                    left: -40.w,
                    child: SlideTransition(
                      position: _positionAnimationMayo,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          SvgPicture.asset(
                            height: (height / 10.5),
                            width: (width / 10.5),
                            ImagesConstants.ellipseRed,
                          ),
                          Transform.translate(
                            offset: Offset(10.w, 5.h),
                            child: Image.asset(
                              ImagesConstants.mayoIsometric,
                              height: (height / 4.6),
                              width: (width / 1.95),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Fast delivery
                  Positioned(
                    top: height / 2,
                    child: ValueListenableBuilder(
                      valueListenable: _opacityEllipseSmall,
                      builder: (context, value, child) => AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: value,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              ImagesConstants.ellipseSmall,
                              width: 114.06.w,
                              height: 84.97.h,
                            ),
                            Text(
                              'Fast delivery',
                              style: TextStyle(
                                height: 0,
                                fontSize: 40.sp,
                                color: HexColor("#000000"),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Taste that best, its on time.',
                              style: TextStyle(
                                fontSize: 20.sp,
                                height: 0,
                                color: HexColor("#000000"),
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Burger blue circle
                  Positioned(
                    top: height / 1.6,
                    right: -20.w,
                    child: SlideTransition(
                      position: _positionAnimationBurger,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          SvgPicture.asset(
                            height: (height / 6.5),
                            width: (width / 6.5),
                            ImagesConstants.burgerBlueCircle,
                          ),
                          Transform.translate(
                            offset: Offset(-10.w, -55.h),
                            child: Image.asset(
                              ImagesConstants.burgerIsometric,
                              height: (height / 4.6),
                              width: (width / 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // tridonut
                  Positioned(
                    top: height / 1.4,
                    left: 0,
                    child: SlideTransition(
                      position: _positionAnimationTridonut,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Transform.rotate(
                            angle: 4.7,
                            child: SvgPicture.string(
                              height: (height / 6.5),
                              width: (width / 6.5),
                              burgerCircleWithColor("#CEE9D5", 0.67),
                            ),
                          ),
                          Positioned(
                            right: -30,
                            child: Image.asset(
                              ImagesConstants.tridonut,
                              height: (height / 5.5),
                              width: (width / 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Fries front
                  Positioned(
                    top: 0.h,
                    left: 60.w,
                    child: SlideTransition(
                      position: _positionAnimation,
                      child: Stack(
                        alignment: Alignment(-0.1, -0.1.h),
                        children: [
                          SvgPicture.asset(
                            ImagesConstants.ellipseBlue,
                            height: height / 7.5,
                            width: width / 7.5,
                          ),
                          Image.asset(
                            ImagesConstants.friesFront,
                            height: height / 4,
                            width: width / 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Cola isometric
                  Positioned(
                    top: height / 6.4,
                    left: 0.w,
                    child: SlideTransition(
                      position: _positionAnimationCola,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: ValueListenableBuilder(
                              valueListenable: _opacityColaCircle,
                              builder: (context, value, child) {
                                return AnimatedOpacity(
                                  opacity: value,
                                  duration: Duration(seconds: 1),
                                  child: SvgPicture.asset(
                                    height: (height / 10.5),
                                    width: (width / 10.5),
                                    ImagesConstants.ellipseGreen,
                                  ),
                                );
                              },
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String burgerCircleWithColor(String color, double opacity) {
    return '''<svg xmlns="http://www.w3.org/2000/svg" width="144" height="139" viewBox="0 0 144 139" fill="none">
  <path opacity="$opacity" d="M88.2197 11.9944C90.3169 4.63218 98.0775 0.249347 104.898 3.72573C116.199 9.48624 125.843 18.1919 132.744 29.0326C142.145 43.7998 145.801 61.5025 143.021 78.7857C140.24 96.0688 131.215 111.731 117.658 122.805C104.1 133.878 86.9505 139.593 69.4602 138.867C51.9699 138.14 35.3539 131.022 22.7613 118.862C10.1687 106.702 2.47466 90.345 1.13727 72.8907C-0.200107 55.4365 4.91216 38.0981 15.5052 24.1616C23.2815 13.9307 33.6149 6.05505 45.3551 1.25187C52.4401 -1.64678 59.8104 3.36471 61.2898 10.8755C64.1041 25.1646 84.2297 26.0008 88.2197 11.9944Z" fill="$color"/>
</svg>''';
  }
}
