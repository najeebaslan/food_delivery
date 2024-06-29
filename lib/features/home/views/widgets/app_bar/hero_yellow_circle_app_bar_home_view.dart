import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/widget/base_hero_transition.dart';

class HeroYellowCircleAppBarHomeView extends StatelessWidget {
  const HeroYellowCircleAppBarHomeView({
    super.key,
    this.endTweenAnimation,
    this.heroWidgetAngle,
    this.heroWidgetHeight,
    this.heroWidgetWidth,
    this.imageYellowAngle,
    this.animatedBuilderChildAngle,
  });
  final double? endTweenAnimation;
  final double? heroWidgetAngle;
  final double? heroWidgetHeight;
  final double? heroWidgetWidth;
  final double? imageYellowAngle;
  final double Function(
    double animationValue,
  )? animatedBuilderChildAngle;

  @override
  Widget build(BuildContext context) {
    return BaseHeroTransition(
      endTweenAnimation: endTweenAnimation ?? 3.3,
      heroTag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
      heroWidget: Transform.rotate(
        angle: heroWidgetAngle ?? 6.2,
        child: _buildImageCircleYellow(),
      ),
      animatedBuilderChild: (rotationAnimation) {
        return Transform.rotate(
          angle: getAngle(rotationAnimation),
          child: Transform.rotate(
            angle: imageYellowAngle ?? 3.2,
            child: _buildImageCircleYellow(),
          ),
        );
      },
      animatedBuilderBuilder: (rotationAnimation, child) {
        return Transform(
          transform: Matrix4.identity()
            ..rotateZ(
              -rotationAnimation.value,
            ),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }

  SvgPicture _buildImageCircleYellow() {
    return SvgPicture.asset(
      ImagesConstants.onboardingCircleBoldYellow,
      height: heroWidgetHeight ?? 32.28.h,
      width: heroWidgetWidth ?? 32.28.w,
    );
  }

  double getAngle(Animation<double> rotationAnimation) {
    if (animatedBuilderChildAngle != null) {
      return animatedBuilderChildAngle!(rotationAnimation.value);
    } else {
      return rotationAnimation.value > 0.7 ? 3 : -2.6;
    }
  }
}
