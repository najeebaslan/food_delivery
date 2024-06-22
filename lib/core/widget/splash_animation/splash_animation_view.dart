import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../features/onboarding/onboarding_home_view.dart';
import '../../constants/assets_constants.dart';
import '../../constants/num_constants.dart';
import '../../router/routes_constants.dart';
import '../../styles/app_colors.dart';
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
  final _opacityColaCircle = ValueNotifier<double>(0.0);
  final _opacityFastDelivery = ValueNotifier<double>(0.0);
  final _opacityKetchup = ValueNotifier<double>(1.0);
  final onboardingHeroTags = OnboardingHeroTags(
    drinkTag: 'drinkTag',
    colaCircleTag: 'colaCircleTag',
  );

  late final Animation<double> _opacityColorCircles = Tween<double>(
    begin: 1.0,
    end: 0.5,
  ).animate(curvedAnimationSlider);

  late final curvedAnimationSlider = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInSine,
  );
  bool isAnimationStarted = false;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
 
      forwardAnimationAndNavigatorToOnboarding();

  }

  void forwardAnimationAndNavigatorToOnboarding() {
    Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        isAnimationStarted = true;
        _opacityColaCircle.value = 0.9;
        _opacityFastDelivery.value = 0.9;
        _opacityKetchup.value = 0.0;
      },
    );
    animationController.forward().whenComplete(
      () {
        return Future.delayed(
          const Duration(
            milliseconds: NumConstants.animationDuration,
          ),
          () async {
            // return Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   AppRoutesConstants.onboardingHomeView,
            //   arguments: onboardingHeroTags,
            //   (route) => false,
            // );
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
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    fit: StackFit.loose,
                    children: [
                      FastDeliveryPositioned(
                        height: height,
                        opacityFastDelivery: _opacityFastDelivery,
                      ),
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(0.8.w, -1.7.h),
                        ).animate(curvedAnimationSlider),
                        child: SvgPicture.asset(
                          ImagesConstants.ellipseYellow,
                          height: 149.06.h,
                          width: 149.06.w,
                          colorFilter: ColorFilter.mode(
                            AppColors.yellow.withOpacity(
                              _opacityColorCircles.value,
                            ),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      ColaPositioned(
                        curvedAnimationSlider: curvedAnimationSlider,
                        onboardingHeroTags: onboardingHeroTags,
                        height: height,
                        width: width,
                        opacityColaCircle: _opacityColaCircle,
                      ),

                      // circle burger blue
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(0.8.w, 1.85.h),
                        ).animate(curvedAnimationSlider),
                        child: Transform.scale(
                          scaleX: 0.99,
                          scaleY: 1,
                          child: SvgPicture.asset(
                            ImagesConstants.burgerBlueCircle,
                            height: 143.h,
                            width: 143.w,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              AppColors.blue.withOpacity(
                                _opacityColorCircles.value,
                              ),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(-0.8.w, 2.2.h),
                        ).animate(curvedAnimationSlider),
                        child: Transform.scale(
                          scaleX: 1,
                          scaleY: 1.02,
                          child: Transform.translate(
                            offset: Offset(2.w, -1.h),
                            child: Transform.rotate(
                              angle: 4.6,
                              child: SvgPicture.asset(
                                ImagesConstants.burgerBlueCircle,
                                height: 143.h,
                                width: 143.w,
                                fit: BoxFit.fitWidth,
                                colorFilter: ColorFilter.mode(
                                  AppColors.nearGreen,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(-0.3, -2.7.h),
                        ).animate(curvedAnimationSlider),
                        child: SvgPicture.asset(
                          ImagesConstants.ellipseBlue,
                          height: 121.762.h,
                          width: 121.762.w,
                          colorFilter: ColorFilter.mode(
                            AppColors.blue.withOpacity(
                              _opacityColorCircles.value,
                            ),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(-1.5, -1.h),
                        ).animate(curvedAnimationSlider),
                        child: Hero(
                          tag: onboardingHeroTags.drinkTag,
                          child: SvgPicture.asset(
                            ImagesConstants.onboardingCircleRed,
                            height: (height / 10.5),
                            width: (width / 10.5),
                            colorFilter: ColorFilter.mode(
                              AppColors.red.withOpacity(0.9),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(0.58.w, 0.54.h),
                        ).animate(curvedAnimationSlider),
                        child: Transform.translate(
                          offset: Offset(0, -10.h),
                          child: Image.asset(
                            ImagesConstants.burgerIsometric,
                            height: (height / 2),
                            width: (width / 1.9),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      AnimatedOpacity(
                        duration: const Duration(seconds: 1),
                        opacity: _opacityKetchup.value,
                        child: Image.asset(
                          ImagesConstants.ketchupIsometric,
                          height: (height / 4.2),
                          width: (width / 2.2),
                          fit: BoxFit.contain,
                        ),
                      ),
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(-0.69, -0.4.h),
                        ).animate(curvedAnimationSlider),
                        child: Transform.translate(
                          offset: Offset(10.w, 0),
                          child: Image.asset(
                            ImagesConstants.mayoIsometric,
                            height: (height / 4.6),
                            width: (width / 2),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(0.85.w, -1.36.h),
                        ).animate(curvedAnimationSlider),
                        child: Image.asset(
                          height: (height / 4.8),
                          width: (width / 2.7),
                          ImagesConstants.hotDogIsometric,
                        ),
                      ),

                      if (isAnimationStarted)
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: isAnimationStarted ? 1.0 : 0,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.0),
                              end: Offset(-0.58.w, 0.8.h),
                            ).animate(curvedAnimationSlider),
                            child: Image.asset(
                              ImagesConstants.tridonut,
                              height: (height / 2.5),
                              width: (width / 2.15),
                            ),
                          ),
                        ),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(-0.15, -1.4.h),
                        ).animate(curvedAnimationSlider),
                        child: Image.asset(
                          ImagesConstants.friesFront,
                          height: height / 4,
                          width: width / 1.8,
                        ),
                      ),
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: Offset(-0.69, -0.95.h),
                        ).animate(curvedAnimationSlider),
                        child: Image.asset(
                          ImagesConstants.colaIsometric,
                          height: (height / 4),
                          width: (width / 2),
                        ),
                      ),
                    ],
                  );
                },
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

  final Map<String, List<Widget>> widgets = {
    '': <Widget>[
      const Text('data'),
    ]
  };
}
