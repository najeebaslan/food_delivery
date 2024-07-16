import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/utils/custom_curves.dart';

import '../../../../../core/utils/custom_rect_tween.dart';
import '../../../blocs/home_cubit/home_cubit.dart';

class HeroSmallRedCircleAppBarHomeView extends StatelessWidget {
  const HeroSmallRedCircleAppBarHomeView({
    super.key,
    this.height,
    this.width,
    this.color,
    required this.angle,
    this.enableEffectRotate = true,
  });

  final double? height;
  final double? width;
  final double angle;
  final Color? color;
  final bool enableEffectRotate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (HomeCubit.get(context).navigateTo == null) {
          return Hero(
            tag: HeroTagsConstants.circleRedTagShared,
            child: _buildImageSmallRedCircle(),
          );
        } else {
          return Hero(
            tag: HeroTagsConstants.circleRedTagShared,
            flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              final rotationAnimation = Tween<double>(
                begin: 0.0,
                end: 2.38,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: enableEffectRotate == false
                      ? easeInOutBackSlow10
                      : Curves.easeInOutBack,
                ),
              );

              return AnimatedBuilder(
                animation: animation,
                child: _buildImageSmallRedCircle(),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: rotationAnimation.value,
                    child: child,
                  );
                },
              );
            },
            createRectTween: (begin, end) {
              return CustomRectTween(
                begin: begin!,
                end: end!,
              );
            },
            child: Transform.rotate(
              angle: angle,
              child: _buildImageSmallRedCircle(),
            ),
          );
        }
      },
    );
  }

  SvgPicture _buildImageSmallRedCircle() {
    return SvgPicture.asset(
      ImagesConstants.homeFillRedCircle,
      height: height ?? 32.28.h,
      width: width ?? 32.28.w,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
