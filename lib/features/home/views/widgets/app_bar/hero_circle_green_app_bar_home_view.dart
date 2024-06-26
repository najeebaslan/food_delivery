import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/widget/base_hero_transition.dart';
import 'package:food_delivery/features/onboarding/widgets/onboarding_circle_bold_green.dart';

import '../../../../../core/widget/custom_rect_tween.dart';

class HeroCircleGreenAppBarHomeView extends StatelessWidget {
  const HeroCircleGreenAppBarHomeView({
    super.key,
    this.endTweenAnimation,
    this.heroWidgetAngle,
    this.heroWidgetHeight,
    this.heroWidgetWidth,
    this.animatedBuilderChildAngle,
  });
  final double? endTweenAnimation;
  final double? heroWidgetAngle;
  final double? heroWidgetHeight;
  final double? heroWidgetWidth;
  final double Function(
    double animationValue,
  )? animatedBuilderChildAngle;

  @override
  Widget build(BuildContext context) {
    return BaseHeroTransition(
      heroTag: HeroTagsConstants.smallCircleGreenTagHomeViewAppBar,
      heroWidget: Transform.rotate(
        angle:heroWidgetAngle?? 3,
        child: _buildImageCircleYellowWithOpacity(),
      ),
      animatedBuilderChild: (rotationAnimation) {
        return Transform.rotate(
          angle: getAngle(rotationAnimation),
          child: Transform.rotate(
            angle: 6.3,
            child: _buildImageCircleYellowWithOpacity(),
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

  Opacity _buildImageCircleYellowWithOpacity() {
    return Opacity(
      opacity: 0.2,
      child: OnboardingCircleGreenSmallWidget(
        width: heroWidgetWidth ?? 32.25.w,
      ),
    );
  }

  double getAngle(Animation<double> rotationAnimation) {
    if (animatedBuilderChildAngle != null) {
      return animatedBuilderChildAngle!(rotationAnimation.value);
    } else {
      return rotationAnimation.value > 0.7 ? 3 : -2.3;
    }
  }
}
