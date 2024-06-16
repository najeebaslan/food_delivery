import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/assets_constants.dart';
import 'widgets/body_onboarding.dart';

class OnboardingHomeView extends StatelessWidget {
  const OnboardingHomeView({super.key, required this.onboardingHeroTags});
  final OnboardingHeroTags onboardingHeroTags;
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
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: 20.w,
          left: 20.w,
        ),
        child: Stack(
          alignment: Alignment.center,
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
                tag: onboardingHeroTags.colaCircleTag,
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
            Positioned(
              top: 340.h,
              left: 10.w,
              child: Hero(
                tag: onboardingHeroTags.drinkTag,
                child: SvgPicture.asset(
                  ImagesConstants.onboardingCircleRed,
                  height: 69.33.h,
                  width: 69.33.w,
                 
                ),
              ),
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
