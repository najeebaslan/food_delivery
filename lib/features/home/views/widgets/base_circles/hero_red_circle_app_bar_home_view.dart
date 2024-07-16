import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/widget/base_animations/base_hero_transition.dart';

import '../../../../../core/constants/hero_tags_constants.dart';
import '../../../../product_details/views/widgets/base_circles/hero_blue_circle_product.dart';
import '../../../blocs/home_animation_cubit/home_animation_cubit.dart';

class HeroRedCircleAppBarHomeView extends StatelessWidget {
  const HeroRedCircleAppBarHomeView({super.key, this.parameters});
  final HeroRedCircleParameters? parameters;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
      buildWhen: (previous, current) =>
          current is NavigateToView || current is ChangeRedCircleColor,
      builder: (context, state) {
        if (context.read<HomeAnimationCubit>().navigateTo == NavigateTo.productDetails ||
            parameters?.showProductDetails == false) {
          return HeroBlueCircleProduct(parameters: parameters);
        } else {
          return BaseHeroTransition(
            heroTag: HeroTagsConstants.bigCircleRedTagHomeViewAppBar,
            heroWidget: Transform.rotate(
              angle: parameters?.angle ?? 3,
              child: imageCircleRedWithOpacity(parameters?.color),
            ),
            animatedBuilderChild: (rotationAnimation) {
              return Transform.rotate(
                angle: getAngle(rotationAnimation),
                child: imageCircleRedWithOpacity(parameters?.color),
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
      },
    );
  }

  double getAngle(Animation<double> rotationAnimation) {
    if (parameters?.animatedBuilderChildAngle != null) {
      return parameters!.animatedBuilderChildAngle!(
        rotationAnimation.value,
      );
    } else {
      return rotationAnimation.value > 0.7 ? 3 : -2.3;
    }
  }

  Opacity imageCircleRedWithOpacity([Color? color]) {
    return Opacity(
      opacity: 0.10,
      child: SvgPicture.asset(
        ImagesConstants.ellipseRed,
        height: parameters?.height ?? 65.30.h,
        width: parameters?.height ?? 65.30.w,
        colorFilter: color != null
            ? ColorFilter.mode(
                color,
                BlendMode.srcIn,
              )
            : null,
      ),
    );
  }
}

class HeroRedCircleParameters {
  final double? angle;
  final double? height;
  final double? width;
  final Color? color;
  final bool? showProductDetails;

  final double Function(
    double animationValue,
  )? animatedBuilderChildAngle;
  HeroRedCircleParameters({
    this.angle,
    this.height,
    this.color,
    this.width,
    this.animatedBuilderChildAngle,
    this.showProductDetails = false,
  });
}
