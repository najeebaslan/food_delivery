import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/assets_constants.dart';
import 'onboarding_cubit/onboarding_cubit.dart';
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
      duration: Duration(milliseconds: 900),
    );

    onboardingCubit.initAnimation();
  }

  @override
  void dispose() {
    onboardingCubit.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 331.h,
                width: 331.w,
                child: Image.asset(
                  ImagesConstants.deliveryManOnboarding,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 100.h,
              child: Hero(
                tag: widget.onboardingHeroTags.colaCircleTag,
                child: SvgPicture.asset(
                  ImagesConstants.circleBorderGreen,
                  height: 56.27.h,
                  width: 56.27.w,
                ),
              ),
            ),
            Positioned(
              top: 130.h,
              right: 20.w,
              child: SvgPicture.asset(
                ImagesConstants.circleBorderYellow,
              ),
            ),
            AnimationCircleBoldRed(
              onboardingCubit: onboardingCubit,
              onboardingHeroTags: widget.onboardingHeroTags.drinkTag,
            ),
            Positioned(
              bottom: 130.h,
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
