import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/widget/custom_rect_tween.dart';
import '../../../blocs/home_cubit/home_cubit.dart';

class HeroSmallRedCircleAppBarHomeView extends StatelessWidget {
  const HeroSmallRedCircleAppBarHomeView({
    super.key,
    this.height,
    this.width,
    this.angle,
  });


  final double? height;
  final double? width;
  final double? angle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Hero(
          tag:
          HeroTagsConstants.drinkTag,
           
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
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
              animation: animation,
              child: Transform.rotate(
                angle: 6,
                child: _buildImageSmallRedCircle(),
              ),
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
            angle: angle ?? 6,
            child: _buildImageSmallRedCircle(),
          ),
        );
      },
    );
  }

  SvgPicture _buildImageSmallRedCircle() {
    return SvgPicture.asset(
      ImagesConstants.ellipseRed,
      height: height ?? 32.28.h,
      width: width ?? 32.28.w,
    );
  }
}
