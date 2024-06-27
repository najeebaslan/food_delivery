import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

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
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final _opacityColaCircle = ValueNotifier<double>(0.0);
  final _opacityFastDelivery = ValueNotifier<double>(0.0);
  final _opacityKetchup = ValueNotifier<double>(1.0);
  final isAnimationStarted = ValueNotifier<bool>(false);
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
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    startAnimation();
  }

  void startAnimation() {
    _opacityColaCircle.value = 0.9;
    isAnimationStarted.value = true;
    _opacityKetchup.value = 0.0;
    animationController.forward().whenComplete(
          navigatorToOnboardingView,
        );

    Future.delayed(
      const Duration(milliseconds: 200),
      () => _opacityFastDelivery.value = 0.9,
    );
  }

  void navigatorToOnboardingView() {
    Future.delayed(
      const Duration(
        milliseconds: NumConstants.animationDuration,
      ),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutesConstants.onboardingHomeView,
        arguments: onboardingHeroTags,
        (route) => false,
      ),
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
                  FastDeliveryPositioned(
                    height: height,
                    opacityFastDelivery: _opacityFastDelivery,
                  ),
                  _buildYellowCircle(height, width),
                  ColaCircleGreenWithHero(
                    curvedAnimationSlider: curvedAnimationSlider,
                    onboardingHeroTags: onboardingHeroTags,
                    height: height,
                    width: width,
                    opacityColaCircle: _opacityColaCircle,
                  ),
                  _buildBurgerBlueCircle(height, width),
                  _buildSweetGreenCircle(),
                  _buildFriesBlueCircle(height, width),
                  _buildCircleRed(height, width),
                  _buildImageBurgerBlueCircle(height, width),
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
                  _buildImageCircleRed(height, width),
                  _buildImageYellowCircle(height, width),
                  _buildImageSweetCircleGreen(height, width),
                  _buildImageFriesBlueCircle(height, width),
                  _buildImageColaCircleGreen(height, width),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SlideTransition _buildImageColaCircleGreen(double height, double width) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(
          context.isSmallDevice ? -0.90.w : -0.69.w,
          context.isSmallDevice ? -1.26.h : -0.95.h,
        ),
      ).animate(curvedAnimationSlider),
      child: Image.asset(
        ImagesConstants.colaIsometric,
        height: height / 4,
        width: width / 2,
      ),
    );
  }

  SlideTransition _buildImageFriesBlueCircle(double height, double width) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(-0.15.w, -1.6.h),
      ).animate(curvedAnimationSlider),
      child: Image.asset(
        ImagesConstants.friesFront,
        height: 200.31.h,
        width: 200.31.w,
      ),
    );
  }

  Widget _buildImageSweetCircleGreen(double height, double width) {
    return ValueListenableBuilder(
      valueListenable: isAnimationStarted,
      builder: (context, value, child) {
        return value
            ? Positioned(
                bottom: context.isSmallDevice ? 0 : null,
                left: context.isSmallDevice ? 0 : null,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1.0,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.0),
                      end: Offset(
                        context.isSmallDevice ? -0.70.w : -0.58.w,
                        context.isSmallDevice ? 1.75.h : 1.68.h,
                      ),
                    ).animate(curvedAnimationSlider),
                    child: Image.asset(
                      ImagesConstants.tridonut,
                      height: context.isSmallDevice ? 155.3.h : 180.31.h,
                      width: context.isSmallDevice ? 155.3.w : 180.31.w,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  SlideTransition _buildImageCircleRed(double height, double width) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(-0.69, -0.4.h),
      ).animate(curvedAnimationSlider),
      child: Transform.translate(
        offset: Offset(10.w, 0),
        child: Image.asset(
          ImagesConstants.mayoIsometric,
          height: 193.302.h,
          width: 193.302.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  SlideTransition _buildCircleRed(double height, double width) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(-1.5, -1.h),
      ).animate(curvedAnimationSlider),
      child: Hero(
        tag: onboardingHeroTags.drinkTag,
        child: SvgPicture.asset(
          ImagesConstants.onboardingCircleRed,
          height: 82.981.h,
          width: 82.981.w,
          colorFilter: ColorFilter.mode(
            AppColors.red,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  AnimatedBuilder _buildFriesBlueCircle(double height, double width) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: Offset(-0.3, -2.7.h),
            ).animate(curvedAnimationSlider),
            child: SvgPicture.asset(
              ImagesConstants.friesBlue,
              height: 121.76.h,
              width: 121.76.w,
              colorFilter: ColorFilter.mode(
                AppColors.blue.withOpacity(
                  _opacityColorCircles.value,
                ),
                BlendMode.srcIn,
              ),
            ),
          );
        });
  }

  Positioned _buildSweetGreenCircle() {
    return Positioned(
      bottom: context.isSmallDevice ? 0 : null,
      left: context.isSmallDevice ? 0 : null,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: Offset(-0.8.w, 2.2.h),
        ).animate(curvedAnimationSlider),
        child: Transform.scale(
          scaleX: 1,
          scaleY: 1.02,
          child: Transform.translate(
            offset: Offset(0.w, -1.h),
            child: Transform.rotate(
              angle: 4.6,
              child: SvgPicture.asset(
                ImagesConstants.burgerBlueCircle,
                height: context.isSmallDevice ? 120.h : 143.h,
                width: context.isSmallDevice ? 120.w : 143.w,
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
    );
  }

  Widget _buildImageBurgerBlueCircle(double height, double width) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(
          context.isSmallDevice ? 0.76.w : 0.58.w,
          context.isSmallDevice ? 1.4.h : 1.12.h,
        ),
      ).animate(curvedAnimationSlider),
      child: Transform.translate(
        offset: Offset(0, context.isSmallDevice ? -3.h : -10.h),
        child: Image.asset(
          ImagesConstants.burgerIsometric,
          height: context.isSmallDevice ? 200.3.h : 220.31.h,
          width: context.isSmallDevice ? 200.3.w : 220.31.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  AnimatedBuilder _buildBurgerBlueCircle(double height, double width) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.0),
            end: Offset(
              context.isSmallDevice ? 1.3.w : 0.87.w,
              context.isSmallDevice ? 2.45.h : 1.80.h,
            ),
          ).animate(curvedAnimationSlider),
          child: Transform.scale(
            scaleX: 0.99,
            scaleY: 1,
            child: SvgPicture.asset(
              ImagesConstants.burgerBlueCircle,
              height: context.isSmallDevice ? 120.h : 143.h,
              width: context.isSmallDevice ? 120.w : 143.w,
              colorFilter: ColorFilter.mode(
                AppColors.blue.withOpacity(
                  _opacityColorCircles.value,
                ),
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      },
    );
  }

  SlideTransition _buildImageYellowCircle(double height, double width) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(
          context.isSmallDevice ? 1.4.w : 0.85.w,
          context.isSmallDevice ? -1.39.h : -1.65.h,
        ),
      ).animate(curvedAnimationSlider),
      child: Image.asset(
        ImagesConstants.hotDogIsometric,
        height: context.isSmallDevice ? 130.h : 142.h,
        width: context.isSmallDevice ? 130.w : 142.w,
      ),
    );
  }

  AnimatedBuilder _buildYellowCircle(double height, double width) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.0),
            end: Offset(context.isSmallDevice ? 1.6.w : 0.8.w, -1.5.h),
          ).animate(curvedAnimationSlider),
          child: SvgPicture.asset(
            ImagesConstants.ellipseYellow,
            height: height / 6.2,
            width: width / 6.5,
            colorFilter: ColorFilter.mode(
              AppColors.yellow.withOpacity(
                _opacityColorCircles.value,
              ),
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}
