import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../features/onboading/onboarding_home_view.dart';
import '../../constants/assets_constants.dart';
import '../../constants/num_constants.dart';
import '../../router/routes_constants.dart';
import 'widgets/cola_positioned.dart';
import 'widgets/fast_delivery_positioned.dart';

class SplashAnimationView extends StatefulWidget {
  const SplashAnimationView({super.key});

  @override
  State<SplashAnimationView> createState() => _SplashAnimationViewState();
}

class _SplashAnimationViewState extends State<SplashAnimationView>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation animation;
  final _opacityColaCircle = ValueNotifier<double>(0.0);
  final _opacityFastDelivery = ValueNotifier<double>(0.0);
  final onboardingHeroTags = OnboardingHeroTags(
    drinkTag: 'drinkTag',
    colaCircleTag: 'colaCircleTag',
  );
  late final Animation<Offset> _positionAnimation = Tween<Offset>(
    begin: Offset(0.0, 1.5.h),
    end: Offset(-0.0, .2.h),
  ).animate(curvedAnimationSlider);

  late final Animation<Offset> _positionAnimationCola = Tween<Offset>(
    begin: Offset(1.0, 3.5.h),
    end: Offset(0.0, .5.h),
  ).animate(curvedAnimationSlider);

  late final Animation<Offset> _positionAnimationSandwich = Tween<Offset>(
    begin: Offset(-.7, 2.5.h),
    end: Offset(0.0, .5.h),
  ).animate(curvedAnimationSlider);
  late final Animation<Offset> _positionAnimationDrink = Tween<Offset>(
    begin: Offset(.5, 1.h),
    end: Offset(0.0, .5.h),
  ).animate(curvedAnimationSlider);

  late final Animation<Offset> _positionAnimationBurger = Tween<Offset>(
    begin: Offset(-.5, -0.6.h),
    end: Offset(0.0, .5.h),
  ).animate(curvedAnimationSlider);
  late final Animation<Offset> _positionAnimationTridonut = Tween<Offset>(
    begin: Offset(.5, -1.5.h),
    end: Offset(0.0, .5.h),
  ).animate(curvedAnimationSlider);

  late final curvedAnimationSlider = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInSine,
  );

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    forwardAnimationAndNavigatorToOnboarding();
  }

  void forwardAnimationAndNavigatorToOnboarding() {
    Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        _opacityColaCircle.value = 0.9;
        _opacityFastDelivery.value = 0.9;
      },
    );
    animationController.forward().whenComplete(
      () {
        return Future.delayed(
          const Duration(
            milliseconds: NumConstants.animationDurationTime,
          ),
          () async {
            return Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutesConstants.OnboardingHomeView,
              arguments: onboardingHeroTags,
              (route) => false,
            );
          },
        );
      },
    );
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
                  // Sandwich
                  Positioned(
                    top: 100.h,
                    right: 0.w,
                    child: SlideTransition(
                      position: _positionAnimationSandwich,
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

                  // Drink
                  Positioned(
                    top: height / 5,
                    left: -40.w,
                    child: SlideTransition(
                      position: _positionAnimationDrink,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Hero(
                            tag: onboardingHeroTags.drinkTag,
                            child: SvgPicture.asset(
                              height: (height / 10.5),
                              width: (width / 10.5),
                              ImagesConstants.onboardingCircleRed,
                            ),
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
                  FastDeliveryPositioned(
                    height: height,
                    opacityFastDelivery: _opacityFastDelivery,
                  ),

                  // Burger blue circle
                  Positioned(
                    top: height / 1.6,
                    left: width / 1.8,
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
                            offset: Offset(-10.w, -height / 18),
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
                  // Potato Cut
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
                  // Cola
                  ColaPositioned(
                    height: height,
                    positionAnimationCola: _positionAnimationCola,
                    onboardingHeroTags: onboardingHeroTags,
                    width: width,
                    opacityColaCircle: _opacityColaCircle,
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
