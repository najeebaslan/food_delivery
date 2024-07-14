import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/hero_tags_constants.dart';
import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../../core/utils/custom_rect_tween.dart';
import '../../../product_details_cubit/product_details_cubit.dart';

class YellowCircle extends StatefulWidget {
  const YellowCircle({super.key});

  @override
  State<YellowCircle> createState() => _YellowCircleState();
}

class _YellowCircleState extends State<YellowCircle> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _yellowCirclePosition;
  late Animation<double> _yellowCircleOpacity;
  late Animation<double> _yellowCircleSize;
  late Animation<double> _yellowCircleRotate;
  late final curve = CurvedAnimation(
    parent: _animationController,
    curve: easeInOutBackSlow,
    reverseCurve: easeInOutBackSlow,
  );
  late ProductDetailsCubit _productCubit;
  @override
  void initState() {
    super.initState();
    _productCubit = ProductDetailsCubit.get(context);
    _animationController = AnimationController(
      
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration450,
      ),
      reverseDuration: const Duration(
        milliseconds: NumConstants.duration1350,
      ),
    
    );
    initAnimations();
  }

  void initAnimations() {
    _yellowCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.85, -0.8),
    ).animate(curve);

    _yellowCircleSize = Tween<double>(
      begin: 78.358,
      end: 116.305,
    ).animate(curve);

    _yellowCircleRotate = Tween<double>(
      begin: 0,
      end: -0.7,
    ).animate(curve);

    _yellowCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.15,
    ).animate(curve);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (_productCubit.animationChooseSizeStatus ==
            AnimationChooseSizeStatus.started) {
          _animationController.forward();
        } else if (_productCubit.animationChooseSizeStatus ==
            AnimationChooseSizeStatus.reverse) {
          _animationController.reverse();
        }
      },
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return _yellowCircle();
          },
        );
      },
    );
  }

  Widget _yellowCircle() {
    return FadeTransition(
      opacity: _yellowCircleOpacity,
      child: SlideTransition(
        position: _yellowCirclePosition,
        child: Hero(
          tag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
          createRectTween: (begin, end) {
            return CustomRectTween(
              begin: begin!,
              end: end!,
            );
          },
          child: Transform.rotate(
            angle: _yellowCircleRotate.value,
            child: SvgPicture.string(
              SVGImageConstants.yellowCircle,
              height: _yellowCircleSize.value.h,
              width: _yellowCircleSize.value.w,
            ),
          ),
        ),
      ),
    );
  }
}
