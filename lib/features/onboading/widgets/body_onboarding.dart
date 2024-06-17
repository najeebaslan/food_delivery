import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widget/custom_elevated_button.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class BodyOnboardingHome extends StatelessWidget {
  const BodyOnboardingHome({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final List<String> title;
  final List<String> subtitle;

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
                      text: title[onboardingStats.indexIndicator],
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
                    milliseconds: NumConstants.animationDurationTime,
                  ),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    key: ValueKey(onboardingStats.indexIndicator.toString() + 'subtitle'),
                    subtitle[onboardingStats.indexIndicator],
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
              duration: Duration(milliseconds: NumConstants.animationDurationTime),
              onDotClicked: (index) => onboardingStats.nextIndicator(index: index),
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
            CustomElevatedButton(
              backgroundColor: onboardingStats.indexIndicator == 1
                  ? AppColors.green
                  : onboardingStats.indexIndicator == 2
                      ? AppColors.red
                      : null,
              title: 'Order Food',
              onPressed: () => onboardingStats.nextIndicator(),
            ),
          ],
        );
      },
    );
  }
}
