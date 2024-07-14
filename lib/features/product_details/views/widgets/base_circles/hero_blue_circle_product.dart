import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/utils/custom_rect_tween.dart';

import '../../../../home/blocs/home_cubit/home_cubit.dart';
import '../../../../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';

class HeroBlueCircleProduct extends StatelessWidget {
  const HeroBlueCircleProduct(
      {super.key, required this.parameters, this.child, this.tag});
  final HeroRedCircleParameters? parameters;
  final Widget Function(Color? color)? child;
  final String? tag;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is NavigateToView || current is ChangeRedCircleColor,
      builder: (context, state) {
        final cubitHomeView = BlocProvider.of<HomeCubit>(context);

        return Hero(
          tag: tag ?? HeroTagsConstants.bigCircleRedTagHomeViewAppBar,
          child: Transform.rotate(
            angle: parameters?.angle ?? 3,
            child: imageCircleBlueWithOpacity(
              cubitHomeView.colorBlueOrRedCircle,
            ),
          ),
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            final rotationAnimation = Tween<double>(
              begin: 0.0,
              end: 2.3,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutBack,
              ),
            );

            return AnimatedBuilder(
              animation: rotationAnimation,
              builder: (context, child) {
                if (rotationAnimation.value > 1.5 && rotationAnimation.value < 1.7) {
                  cubitHomeView.changeRedCircleColor(
                    AppColors.blue,
                  );
                } else if (rotationAnimation.value < 1.5 &&
                    rotationAnimation.value > 1.2) {
                  cubitHomeView.changeRedCircleColor(
                    AppColors.red,
                  );
                }
                return Transform.rotate(
                  angle: getAngle(rotationAnimation),
                  child: imageCircleBlueWithOpacity(
                    cubitHomeView.colorBlueOrRedCircle,
                  ),
                );
              },
            );
          },
          createRectTween: (begin, end) => CustomRectTween(
            begin: begin!,
            end: end!,
          ),
        );
      },
    );
  }

  double getAngle(Animation<double> rotationAnimation) {
    if (parameters?.animatedBuilderChildAngle != null) {
      return parameters!.animatedBuilderChildAngle!(
        rotationAnimation.value,
      );
    } else {
      return rotationAnimation.value > 0.7 ? 3 :3;
    }
  }

  Widget imageCircleBlueWithOpacity([Color? color]) {
    if (child != null) return child!(color);
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
