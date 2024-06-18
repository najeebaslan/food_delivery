import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widget/custom_elevated_button.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class BodyOnboardingHome extends StatefulWidget {
  const BodyOnboardingHome({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final List<String> title;
  final List<String> subtitle;

  @override
  State<BodyOnboardingHome> createState() => _BodyOnboardingHomeState();
}

class _BodyOnboardingHomeState extends State<BodyOnboardingHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  int indexIndicator = 0;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1300),
    );
    _colorTween = ColorTween(
      begin: AppColors.blue,
      end: AppColors.green,
    ).animate(_animationController);
    super.initState();
  }

  void changeColors({required int fromIndex, required int toIndex}) {
    final colorMap = {
      (0, 1): _buildColorTween(AppColors.blue, AppColors.green),
      (0, 2): _buildColorTween(AppColors.blue, AppColors.red),
      (2, 1): _buildColorTween(AppColors.red, AppColors.green),
      (1, 0): _buildColorTween(AppColors.green, AppColors.blue),
      (1, 2): _buildColorTween(AppColors.green, AppColors.red),
      (2, 0): _buildColorTween(AppColors.red, AppColors.blue),
    };

    _colorTween = colorMap[(fromIndex, toIndex)]!.animate(_animationController);
    if (_animationController.status == AnimationStatus.completed) {
      _animationController
        ..reset()
        ..forward();
    } else {
      _animationController.forward();
    }
  }

  ColorTween _buildColorTween(Color begin, Color end) {
    return ColorTween(begin: begin, end: end);
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
            SizedBox(height: 46.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text.rich(
                key: ValueKey(onboardingStats.indexIndicator),
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
                      text: widget.title[onboardingStats.indexIndicator],
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.h),
            SizedBox(
              width: 265.w,
              height: 38.w,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: NumConstants.animationDuration,
                  ),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    key: ValueKey(onboardingStats.indexIndicator.toString() + 'subtitle'),
                    widget.subtitle[onboardingStats.indexIndicator],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 44.h),
            AnimatedSmoothIndicator(
              duration: Duration(milliseconds: NumConstants.animationDuration),
              onDotClicked: (index) {
                changeColors(fromIndex: indexIndicator, toIndex: index);
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
            ),
            SizedBox(height: 44.h),
            AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return CustomElevatedButton(
                  backgroundColor: _colorTween.value,
                  title: 'Order Food',
                  onPressed: () {
                    if (onboardingStats.indexIndicator == 2) return;

                    onboardingStats.nextIndicator();
                    changeColors(
                      fromIndex: indexIndicator,
                      toIndex: onboardingStats.indexIndicator,
                    );
                    indexIndicator = onboardingStats.indexIndicator;
                    // changeColors();
                    // onboardingStats.nextIndicator();
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
