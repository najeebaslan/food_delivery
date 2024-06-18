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

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1300),
    );
    _colorTween = ColorTween(begin: AppColors.blue, end: AppColors.green)
        .animate(_animationController);
    super.initState();
  }

  Future changeColors() async {
    final cubitIndex = BlocProvider.of<OnboardingCubit>(context).indexIndicator;
    if (_animationController.status == AnimationStatus.completed) {
      if (cubitIndex == 1) {
        _colorTween = ColorTween(begin: AppColors.red, end: AppColors.green)
            .animate(_animationController);
      } else if (cubitIndex == 0) {
        _colorTween = ColorTween(begin: AppColors.blue, end: AppColors.green)
            .animate(_animationController);
      }

      _animationController.reverse();
    } else {
      _animationController.forward();
    }
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
                changeColors();
                onboardingStats.nextIndicator(index: index);
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
                      changeColors();
                      onboardingStats.nextIndicator();
                    },
                  );
                }),
          ],
        );
      },
    );
  }
}
