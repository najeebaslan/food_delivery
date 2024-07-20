import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/styles/app_colors.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../home/views/widgets/base_circles/hero_small_red_circle_app_bar_home_view.dart';
import '../../../cubit/product_details_cubit.dart';

class ChooseSizeRedCircleAnimation extends StatefulWidget {
  const ChooseSizeRedCircleAnimation({super.key});

  @override
  State<ChooseSizeRedCircleAnimation> createState() =>
      _ChooseSizeRedCircleAnimationState();
}

class _ChooseSizeRedCircleAnimationState extends State<ChooseSizeRedCircleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _chooseSizeAnimationController;
  late AnimationController _animationController;
  bool isBackToProductDetailsView = false;
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
    _chooseSizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration900,
      ),
    );
  }

  Animation<double> get _blueCircleOpacity =>
      Tween(begin: 0.0, end: 0.6).animate(_adaptiveCurve);

  Animation<double> get _redCircleOpacity =>
      Tween(begin: 1.0, end: 0.0).animate(_adaptiveCurve);

  Animation<double> get _redCircleRotate =>
      Tween<double>(begin: 0, end: math.pi).animate(_adaptiveCurve);

  Animation<double> get _redCircleSize =>
      Tween<double>(begin: 48.13, end: 84.20).animate(_adaptiveCurve);

  Animation<double> get _redCircleOpacityOnComeAndBackToProductView =>
      Tween<double>(begin: 1, end: 0.2).animate(_defaultCurve);

  Animation<Offset> get _redCircleSlide =>
      Tween<Offset>(begin: Offset.zero, end: const Offset(0.25, 2.2))
          .animate(_defaultCurve);

  CurvedAnimation get _defaultCurve =>
      CurvedAnimation(parent: _animationController, curve: easeInOutBackSlow50);

  CurvedAnimation get _adaptiveCurve {
    return CurvedAnimation(
      parent: isBackToProductDetailsView
          ? _animationController
          : _chooseSizeAnimationController,
      curve: easeInOutBackSlow50,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _chooseSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) => _onBlocListener(state),
        builder: (context, state) => _redCircle(),
      );

  void _onBlocListener(ProductDetailsState state) {
    if (state is ChangeStateAnimation) {
      _handelAnimationController(state);
    }
    if (state is ProductDetailsSizeChanged) {
      _handleChooseSizeAnimationController();
    }
  }

  void _handelAnimationController(ProductDetailsState state) {
    if (_productCubit.isStartChooseSizeAnimation) {
      isBackToProductDetailsView = false;
      _animationController.forward();
    } else if (_productCubit.isReversChooseSizeAnimation) {
      _animationController.reverse();
      if (_productCubit.productDetailsSizeEnum == ProductDetailsSizeEnum.small) {
        isBackToProductDetailsView = true;
        _chooseSizeAnimationController.reverse();
      }
    }
  }

  void _handleChooseSizeAnimationController() {
    if (!_chooseSizeAnimationController.isCompleted &&
        _productCubit.productDetailsSizeEnum == ProductDetailsSizeEnum.small) {
      _chooseSizeAnimationController.forward();
    } else {
      _chooseSizeAnimationController.reverse();
    }
  }

  AnimatedBuilder _redCircle() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _animationController,
        _chooseSizeAnimationController,
      ]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _redCircleOpacityOnComeAndBackToProductView,
          child: SlideTransition(
            position: _redCircleSlide,
            child: Transform.rotate(
              angle: _redCircleRotate.value,
              alignment: Alignment.center,
              child: SizedBox(
                height: _redCircleSize.value.h,
                width: _redCircleSize.value.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    HeroSmallRedCircleAppBarHomeView(
                      angle: 2.38,
                      enableEffectRotate: false,
                      height: _redCircleSize.value.h,
                      width: _redCircleSize.value.w,
                      color: AppColors.red.withOpacity(
                        _redCircleOpacity.value.clamp(0.0, 1.0),
                      ),
                    ),
                    Transform.rotate(
                      angle: 3.2,
                      child: SvgPicture.asset(
                        ImagesConstants.fatBorderCircle,
                        width: _redCircleSize.value.w,
                        height: _redCircleSize.value.h,
                        colorFilter: ColorFilter.mode(
                          AppColors.nearBlue.withOpacity(
                            _blueCircleOpacity.value.clamp(0.0, 0.6),
                          ),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
