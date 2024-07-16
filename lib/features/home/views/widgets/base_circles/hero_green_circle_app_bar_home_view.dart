import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/widget/base_animations/base_hero_transition.dart';

class HeroGreenCircleAppBarHomeView extends StatelessWidget {
  const HeroGreenCircleAppBarHomeView({
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
        angle: heroWidgetAngle ?? 3,
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
    );
  }

  SvgPicture _buildImageCircleYellowWithOpacity() {
    return SvgPicture.asset(
      ImagesConstants.greenCircle,
      width: heroWidgetWidth ?? 32.25.w,
      height: heroWidgetWidth ?? 32.h,
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
