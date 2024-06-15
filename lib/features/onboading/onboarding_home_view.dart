import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/features/onboading/blocs/cubit/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/size/app_padding.dart';
import '../../core/styles/app_colors.dart';
import '../../core/widget/custom_elevated_button.dart';

class OnboardingHomeView extends StatefulWidget {
  const OnboardingHomeView({super.key, required this.colaCircleTag});
  final String colaCircleTag;

  @override
  State<OnboardingHomeView> createState() => _OnboardingHomeViewState();
}

class _OnboardingHomeViewState extends State<OnboardingHomeView>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation animation;
  static List<String> title = [
    'Fastest Food delivery',
    'Good Food for Good Moments',
    'Good food smile',
  ];
  static List<String> subtitle = [
    'Want a delicious meal, but no\n time we will deliver it hot and yummy.',
    'Taste that best, its on time.',
    'Want a delicious meal, but no\n time we will deliver it hot and yummy.',
  ];
  late final Animation<double> _positionAnimationTridonut =
      Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

  CurvedAnimation CurvedAnimationSlider() {
    return CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderOnboardingView(
              colaCircleTag: widget.colaCircleTag,
            ),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              buildWhen: (previous, current) => current is NextIndicatorOnboarding,
              builder: (context, state) {
                final onboardingStats = BlocProvider.of<OnboardingCubit>(context);
                return Column(
                  children: [
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 400),
                      opacity: _positionAnimationTridonut.value,
                      curve: Curves.bounceInOut,
                      child: Text.rich(
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
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 0),
                      opacity: onboardingStats.opacityText,
                      child: SizedBox(
                        width: 265.w,
                        height: 38.w,
                        child: Center(
                          child: Text(
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
                      onPressed: () {
                        animationController.repeat(reverse: false);

                        onboardingStats.nextIndicator();
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderOnboardingView extends StatelessWidget {
  const HeaderOnboardingView({
    super.key,
    required this.colaCircleTag,
  });

  final String colaCircleTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: colaCircleTag,
              child: SvgPicture.asset(
                ImagesConstants.circleBorderGreen,
              ),
            ),
            SizedBox(width: 54.w),
            Transform.translate(
              offset: Offset(0, 24.h),
              child: SvgPicture.asset(
                ImagesConstants.circleBorderYellow,
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        SizedBox(
          height: 331.h,
          width: 331.w,
          child: FittedBox(
            child: Image.asset(
              ImagesConstants.deliveryManOnboarding,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 46.h),
      ],
    );
  }
}
