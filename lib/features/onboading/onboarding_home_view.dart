import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/num_constants.dart';
import 'onboarding_cubit/onboarding_cubit.dart';
import 'widgets/animation_circle_bold_green.dart';
import 'widgets/animation_circle_bold_red.dart';
import 'widgets/body_onboarding.dart';

class OnboardingHomeView extends StatefulWidget {
  const OnboardingHomeView({super.key, required this.onboardingHeroTags});
  final OnboardingHeroTags onboardingHeroTags;

  @override
  State<OnboardingHomeView> createState() => _OnboardingHomeViewState();
}

class _OnboardingHomeViewState extends State<OnboardingHomeView>
    with TickerProviderStateMixin {
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
  late OnboardingCubit onboardingCubit;
  @override
  void initState() {
    super.initState();
    onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    onboardingCubit.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: NumConstants.animationDuration - 100),
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
    log(MediaQuery.sizeOf(context).height.toString());
    bool isSmallDevice = MediaQuery.sizeOf(context).height < 600 ? true : false;
    log('rebuild PlatformScaffold');
    return PlatformScaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: 20.w,
          left: 20.w,
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 180.h,
              child: SizedBox(
                height: isSmallDevice ? 250.h : 331.h,
                width: isSmallDevice ? 250.w : 331.w,
                child: Image.asset(
                  ImagesConstants.deliveryManOnboarding,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            HeaderAnimationCircleGreen(
              onboardingCubit: onboardingCubit,
              onboardingHeroTags: widget.onboardingHeroTags.colaCircleTag,
            ),
            Positioned(
              top: 130.h,
              right: 20.w,
              child: SvgPicture.asset(
                ImagesConstants.circleBorderYellow,
                height: 84.91.h,
                width: 84.91.w,
              ),
            ),
            HeaderAnimationCircleBoldRed(
              onboardingCubit: onboardingCubit,
              onboardingHeroTags: widget.onboardingHeroTags.drinkTag,
            ),
            Positioned(
              bottom: isSmallDevice ? 20.h : 130.h,
              child: BodyOnboardingHome(
                title: title,
                subtitle: subtitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingHeroTags {
  final String drinkTag;
  final String colaCircleTag;
  OnboardingHeroTags({
    required this.drinkTag,
    required this.colaCircleTag,
  });
}
