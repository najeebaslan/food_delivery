import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/assets_constants.dart';
import '../core/router/routes_constants.dart';
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
    end: Offset(-0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );

  late final Animation<Offset> _positionAnimationCola = Tween<Offset>(
    begin: Offset(1.0, 1.5.h),
    end: Offset(0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );

  late final Animation<Offset> _positionAnimationHotDog = Tween<Offset>(
    begin: Offset(-.7, 1.5.h),
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
    begin: Offset(-.5, -0.1.h),
    end: Offset(0.0, .5.h),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ),
  );
  late final Animation<Offset> _positionAnimationTridonut = Tween<Offset>(
    begin: Offset(.5, -0.2.h),
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
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutesConstants.OnboardingHomeView, (route) => false);
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
          top: 20.h,
          right: 20.w,
          left: 20.w,
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Hot dog isometric
              Positioned(
                top: 10.h,
                right: -13.w,
                child: SlideTransition(
                  position: _positionAnimationHotDog,
                  child: Column(
                    children: [
                      Transform.rotate(
                        angle: 0.2,
                        child: SvgPicture.asset(
                          height: 143.h,
                          width: 143.w,
                          ImagesConstants.ellipseYellow,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -155.h),
                        child: Image.asset(
                          ImagesConstants.hotDogIsometric,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Mayo isometric
              Positioned(
                top: 170.h,
                left: -30.w,
                child: SlideTransition(
                  position: _positionAnimationMayo,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        height: 80.56.h,
                        width: 80.56.w,
                        ImagesConstants.ellipseRed,
                      ),
                      Transform.translate(
                        offset: Offset(7.w, -140.h),
                        child: Image.asset(
                          ImagesConstants.mayoIsometric,
                          height: 200.302.h,
                          width: 200.302.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Fast delivery
              Positioned(
                top: 412.h,
                child: ValueListenableBuilder(
                  valueListenable: _opacityEllipseSmall,
                  builder: (context, value, child) => AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: value,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          ImagesConstants.ellipseSmall,
                        ),
                        Text(
                          'Fast delivery',
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: HexColor("#000000"),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Taste that best, its on time.',
                          style: TextStyle(
                            fontSize: 20.sp,
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
                top: 450.h,
                right: -21.w,
                child: SlideTransition(
                  position: _positionAnimationBurger,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        height: 143.h,
                        width: 143.w,
                        ImagesConstants.burgerBlueCircle,
                      ),
                      Transform.translate(
                        offset: Offset(0, -190.h),
                        child: Image.asset(
                          ImagesConstants.burgerIsometric,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // tridonut
              Positioned(
                bottom: 100.h,
                left: 21.w,
                child: SlideTransition(
                  position: _positionAnimationTridonut,
                  child: Column(
                    children: [
                      Transform.rotate(
                        angle: 4.7,
                        child: SvgPicture.string(
                          height: 143.h,
                          width: 143.w,
                          burgerCircleWithColor("#CEE9D5", 0.67),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(15.w, -170.h),
                        child: Image.asset(
                          ImagesConstants.tridonut,
                          height: 170.h,
                          width: 170.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Fries front
              Positioned(
                top: -100.h,
                left: 60.w,
                child: SlideTransition(
                  position: _positionAnimation,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        ImagesConstants.ellipseBlue,
                        height: 121.h,
                        width: 121.w,
                      ),
                      Transform.translate(
                        offset: Offset(0, -160.h),
                        child: Image.asset(
                          ImagesConstants.friesFront,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Cola isometric
              Positioned(
                top: 20.h,
                left: -50.w,
                child: SlideTransition(
                  position: _positionAnimationCola,
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _opacityColaCircle,
                        builder: (context, value, child) => AnimatedOpacity(
                          opacity: value,
                          duration: Duration(seconds: 1),
                          child: SvgPicture.asset(
                            height: 82.h,
                            width: 82.w,
                            ImagesConstants.ellipseGreen,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(20, -115.h),
                        child: Image.asset(
                          ImagesConstants.colaIsometric,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
