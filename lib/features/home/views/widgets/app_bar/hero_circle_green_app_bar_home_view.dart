import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/widget/base_hero_transition.dart';
import 'package:food_delivery/features/onboarding/widgets/onboarding_circle_bold_green.dart';

import '../../../../../core/widget/custom_rect_tween.dart';

class HeroCircleGreenAppBarHomeView extends StatelessWidget {
  const HeroCircleGreenAppBarHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseHeroTransition(
      heroTag: HeroTagsConstants.smallCircleGreenTagHomeViewAppBar,
      heroWidget: Opacity(
        opacity: 0.2,
        child: Transform.rotate(
          angle: 3,
          child: OnboardingCircleGreenSmallWidget(
            width: 35.25.w,
          ),
        ),
      ),
      animatedBuilderChild: (rotationAnimation) {
        return Transform.rotate(
          angle: rotationAnimation.value > 0.7 ? 3 : -2.3,
          child: Opacity(
            opacity: 0.2,
            child: Transform.rotate(
              angle: 3,
              child: OnboardingCircleGreenSmallWidget(
                width: 35.25.w,
              ),
            ),
          ),
        );
      },
      animatedBuilderBuilder: (rotationAnimation, child) {
        return Transform(
          transform: Matrix4.identity()
            ..rotateZ(
              rotationAnimation.value,
            ),
          alignment: Alignment.center,
          child: child,
        );
      },
      createRectTween: (begin, end) {
        return CustomRectTween(
          begin: begin!,
          end: end!,
        );
      },
    );
  }
}
