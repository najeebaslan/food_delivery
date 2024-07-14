import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/hero_tags_constants.dart';
import '../../core/constants/num_constants.dart';
import 'onboarding_cubit/onboarding_cubit.dart';
import 'widgets/onboarding_circle_bold_green.dart';
import 'widgets/onboarding_circle_bold_red.dart';
import 'widgets/onboarding_circle_yellow.dart';
import 'widgets/onboarding_step_display.dart';

class OnboardingHomeView extends StatefulWidget {
  const OnboardingHomeView({super.key});

  @override
  State<OnboardingHomeView> createState() => _OnboardingHomeViewState();
}

class _OnboardingHomeViewState extends State<OnboardingHomeView>
    with SingleTickerProviderStateMixin {
  late final OnboardingCubit onboardingCubit;

  @override
  void initState() {
    super.initState();
    onboardingCubit = context.read<OnboardingCubit>();
    onboardingCubit.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumConstants.duration800 - 100),
    );
    onboardingCubit.initAnimation();
  }

  @override
  void dispose() {
    onboardingCubit
      ..animationController.dispose()
      ..animationController.removeStatusListener((status) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = context.isSmallDevice ? 250 : 331;

    return PlatformScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 180.h,
              child: SizedBox(
                height: imageSize.h,
                width: imageSize.w,
                child: Image.asset(
                  ImagesConstants.onboardingDeliveryManOnboarding,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            OnboardingCircleGreen(
              onboardingCubit: onboardingCubit,
              onboardingHeroTags: HeroTagsConstants.colaCircleTagOnboardingView,
            ),
            const OnboardingCircleYellow(),
            OnboardingCircleBoldRed(
              onboardingCubit: onboardingCubit,
              onboardingHeroTags: HeroTagsConstants.circleRedTagShared,
            ),
            Positioned(
              bottom: context.isSmallDevice ? 20.h : 120.h,
              child: const OnboardingStepDisplay(
                redCircleHeroTag: HeroTagsConstants.circleRedTagShared,
                title: [
                  'Fastest Food delivery',
                  'Good Food for Good Moments',
                  'Good food smile',
                ],
                subtitle: [
                  'Want a delicious meal, but no\n time we will deliver it hot and yummy.',
                  'Taste that best, its on time.',
                  'Want a delicious meal, but no\n time we will deliver it hot and yummy.',
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
