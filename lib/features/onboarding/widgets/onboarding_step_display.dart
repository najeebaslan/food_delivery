import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/router/routes_constants.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class OnboardingStepDisplay extends StatefulWidget {
  const OnboardingStepDisplay({
    super.key,
    required this.title,
    required this.subtitle,
    required this.redCircleHeroTag,
  });

  final List<String> title;
  final List<String> subtitle;
  final String redCircleHeroTag;
  @override
  State<OnboardingStepDisplay> createState() => _OnboardingStepDisplayState();
}

class _OnboardingStepDisplayState extends State<OnboardingStepDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  int indexIndicator = 0;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _colorTween = ColorTween(
      begin: AppColors.blue,
      end: AppColors.green,
    ).animate(_animationController);

    _runAutoStepsAnimation(BlocProvider.of<OnboardingCubit>(context));
  }

  void _changeColors({required int fromIndex, required int toIndex}) {
    final colorMap = {
      (0, 1): ColorTween(begin: AppColors.blue, end: AppColors.green),
      (0, 2): ColorTween(begin: AppColors.blue, end: AppColors.red),
      (2, 1): ColorTween(begin: AppColors.red, end: AppColors.green),
      (1, 0): ColorTween(begin: AppColors.green, end: AppColors.blue),
      (1, 2): ColorTween(begin: AppColors.green, end: AppColors.red),
      (2, 0): ColorTween(begin: AppColors.red, end: AppColors.blue),
    };

    _colorTween = colorMap[(fromIndex, toIndex)]!.animate(_animationController);
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reset();
    }
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => current is NextIndicatorOnboarding,
      builder: (context, state) {
        final onboardingStats = BlocProvider.of<OnboardingCubit>(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(onboardingStats.indexIndicator),
            Gap(14.h),
            _buildSubtitle(onboardingStats.indexIndicator),
            Gap(44.h),
            _buildSmoothIndicator(onboardingStats),
            Gap(44.h),
            _buildOrderFoodButton(onboardingStats),
          ],
        );
      },
    );
  }

  AnimatedBuilder _buildOrderFoodButton(OnboardingCubit onboardingStats) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) {
        return Container(
          width: 322.w,
          height: 66.h,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color:
                onboardingStats.indexIndicator != 0 ? _colorTween.value : AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: PlatformText('Order Food', style: AppTextStyles.font20White700W),
        );
      },
    );
  }

  AnimatedSmoothIndicator _buildSmoothIndicator(OnboardingCubit onboardingStats) {
    return AnimatedSmoothIndicator(
      duration: const Duration(
        milliseconds: NumConstants.animationDuration,
      ),
      onDotClicked: (index) {
        _changeColors(fromIndex: indexIndicator, toIndex: index);
        onboardingStats.nextIndicator(index: index);
        indexIndicator = onboardingStats.indexIndicator;
      },
      axisDirection: Axis.horizontal,
      activeIndex: onboardingStats.indexIndicator,
      count: 3,
      effect: SwapEffect(
        dotWidth: 12.w,
        dotHeight: 12.h,
        activeDotColor: AppColors.blue,
        paintStyle: PaintingStyle.stroke,
        dotColor: AppColors.blue,
        strokeWidth: 1,
        spacing: 18.w,
      ),
    );
  }

  SizedBox _buildSubtitle(int index) {
    return SizedBox(
      height: 55.h,
      width: 300.w,
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: NumConstants.animationDuration,
        ),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: PlatformText(
          key: ValueKey('${index}subtitle'),
          widget.subtitle[index],
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  AnimatedSwitcher _buildTitle(int index) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Text.rich(
        key: ValueKey(index),
        textAlign: TextAlign.center,
        TextSpan(
          text: '# ',
          style: TextStyle(
            color: AppColors.red,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(
              text: widget.title[index],
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _runAutoStepsAnimation(OnboardingCubit onboardingStats) async {
    await Future.delayed(
      onboardingStats.indexIndicator == 0
          ? const Duration(seconds: 2)
          : const Duration(
              milliseconds: NumConstants.animationDuration * 2,
            ),
    );

    if (onboardingStats.indexIndicator == 2) {
      _navigatorToHomeView();
    } else {
      onboardingStats.nextIndicator();
      _changeColors(
        fromIndex: indexIndicator,
        toIndex: onboardingStats.indexIndicator,
      );
      indexIndicator = onboardingStats.indexIndicator;
      // ----------------------------    Note: This recursion function   ----------------------------
      _runAutoStepsAnimation(onboardingStats);
    }
  }

  void _navigatorToHomeView() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutesConstants.homeView,
      (route) => false,
      arguments: widget.redCircleHeroTag,
    );
  }
}
