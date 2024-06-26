import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/widget/base_hero_transition.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../../../../core/constants/hero_tags_constants.dart';

class HeroCircleRedAppBarHomeView extends StatelessWidget {
  const HeroCircleRedAppBarHomeView({
    super.key,
    this.heroWidgetAngle,
    this.heroWidgetHeight,
    this.heroWidgetWidth,
    this.animatedBuilderChildAngle,
  });
  final double? heroWidgetAngle;
  final double? heroWidgetHeight;
  final double? heroWidgetWidth;
  final double Function(
    double animationValue,
  )? animatedBuilderChildAngle;
  @override
  Widget build(BuildContext context) {
    return BaseHeroTransition(
      heroTag: HeroTagsConstants.bigCircleRedTagHomeViewAppBar,
      heroWidget: Transform.rotate(
        angle: heroWidgetAngle ?? 3,
        child: imageCircleRedWithOpacity(),
      ),
      animatedBuilderChild: (rotationAnimation) {
        return Transform.rotate(
          angle: getAngle(rotationAnimation),
          child: imageCircleRedWithOpacity(),
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

  double getAngle(Animation<double> rotationAnimation) {
    if (animatedBuilderChildAngle != null) {
      return animatedBuilderChildAngle!(rotationAnimation.value);
    } else {
      return rotationAnimation.value > 0.7 ? 3 : -2.3;
    }
  }

  Opacity imageCircleRedWithOpacity() {
    return Opacity(
      opacity: 0.10,
      child: SvgPicture.asset(
        ImagesConstants.ellipseRed,
        height: heroWidgetHeight ?? 65.30.h,
        width: heroWidgetHeight ?? 65.30.w,
      ),
    );
  }
}
