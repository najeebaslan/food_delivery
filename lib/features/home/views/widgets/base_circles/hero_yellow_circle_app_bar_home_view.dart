import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/widget/base_hero_transition.dart';

import '../../../../../core/widget/custom_rect_tween.dart';
import '../../../blocs/home_cubit/home_cubit.dart';

class HeroYellowCircleAppBarHomeView extends StatelessWidget {
  const HeroYellowCircleAppBarHomeView({
    super.key,
    this.endTweenAnimation,
    this.angle,
    this.height,
    this.width,
    this.imageYellowAngle,
    this.animatedBuilderChildAngle,
  });
  final double? endTweenAnimation;
  final double? angle;
  final double? height;
  final double? width;
  final double? imageYellowAngle;
  final double Function(
    double animationValue,
  )? animatedBuilderChildAngle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is NavigateToView || current is ChangeRedCircleColor,
      builder: (context, state) {
        if (context.read<HomeCubit>().navigateTo == NavigateTo.productDetails) {
          return Hero(
            transitionOnUserGestures: true,
            tag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
            createRectTween: (begin, end) {
              return CustomRectTween(
                begin: begin!,
                end: end!,
              );
            },
            child: SvgPicture.asset(
              ImagesConstants.onboardingCircleBoldYellow,
              height: height ?? 32.28.h,
              width: width ?? 32.28.w,
            ),
          );
        } else {
          return BaseHeroTransition(
            endTweenAnimation: endTweenAnimation ?? 3.3,
            heroTag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
            heroWidget: Transform.rotate(
              angle: angle ?? 6.2,
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
      },
    );
  }

  SvgPicture _buildImageCircleYellow() {
    return SvgPicture.asset(
      ImagesConstants.onboardingCircleBoldYellow,
      height: height ?? 32.28.h,
      width: width ?? 32.28.w,
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
