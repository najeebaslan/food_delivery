import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../home/views/widgets/base_circles/hero_small_red_circle_app_bar_home_view.dart';
import '../../../product_details_cubit/product_details_cubit.dart';

class ChooseSizeRedCircleAnimation extends StatefulWidget {
  const ChooseSizeRedCircleAnimation({super.key});

  @override
  State<ChooseSizeRedCircleAnimation> createState() =>
      _ChooseSizeRedCircleAnimationState();
}

class _ChooseSizeRedCircleAnimationState extends State<ChooseSizeRedCircleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _sizeAndRotateAnimationController;
  late AnimationController _animationController;
  late Animation<Offset> _redCirclePosition;
  late Animation<double> _redCircleOpacity;
  late Animation<double> _redCircleSize;
  late Animation<double> _rotateRedCircle;

  late Animation<Offset> _redCirclePositionOnBackToProduct;
  late Animation<double> _rotateRedCircleOnBackToProduct;

  bool isBackToProductDetailsView = false;
  late final curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutBack,
    reverseCurve: Curves.easeInOutBack,
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
    _sizeAndRotateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration900,
      ),
    );

    _redCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2),
    ).animate(curve);

    _redCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.2,
    ).animate(curve);

    _redCirclePositionOnBackToProduct = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: easeInOutBackSlow35,
      ),
    );

    _rotateRedCircleOnBackToProduct = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: easeInOutBackSlow35,
      ),
    );

    _initSizeRedCircleAnimationOnBackToProductView();
  }

  _initSizeRedCircleAnimationOnBackToProductView() {
    _redCircleSize = Tween<double>(
      begin: 48.13,
      end: 70.204,
    ).animate(
      CurvedAnimation(
        parent: _sizeAndRotateAnimationController,
        curve: Curves.easeInOutBack,
        reverseCurve: Curves.easeInOutBack,
      ),
    );

    _rotateRedCircle = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(
      CurvedAnimation(
        parent: _sizeAndRotateAnimationController,
        curve: easeInOutBackSlow35,
      ),
    );
  }

  void _onBlocListener(ProductDetailsState state) {
    if (state is ChangeStateAnimation) {
      if (_productCubit.isStartChooseSizeAnimation) {
        isBackToProductDetailsView = false;
        _animationController.forward();
      } else if (_productCubit.isReversChooseSizeAnimation) {
        _animationController.reverse();
        if (_productCubit.productDetailsSizeEnum == ProductDetailsSizeEnum.small) {
          isBackToProductDetailsView = true;
          _sizeAndRotateAnimationController.reverse();
        }
      }
    }
    if (state is ProductDetailsSizeChanged) {
      _handleSizeAndRotateAnimationOnBackToProductView();
    }
  }

  void _handleSizeAndRotateAnimationOnBackToProductView() {
    if (!_sizeAndRotateAnimationController.isCompleted &&
        _productCubit.productDetailsSizeEnum == ProductDetailsSizeEnum.small) {
      _sizeAndRotateAnimationController.forward();
    } else {
      _sizeAndRotateAnimationController.reverse();
    }
  }

  AnimatedBuilder _redCircle() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _animationController,
        _sizeAndRotateAnimationController,
      ]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _redCircleOpacity,
          child: SlideTransition(
            position: isBackToProductDetailsView
                ? _redCirclePositionOnBackToProduct
                : _redCirclePosition,
            child: Transform.rotate(
              angle: isBackToProductDetailsView
                  ? _rotateRedCircleOnBackToProduct.value
                  : _rotateRedCircle.value,
              alignment: Alignment.center,
              child: AnimatedCrossFade(
                firstChild: HeroSmallRedCircleAppBarHomeView(
                  height: _redCircleSize.value.h,
                  width: _redCircleSize.value.w,
                  angle: 2,
                ),
                secondChild: Transform.rotate(
                  angle: 3.2,
                  child: SvgPicture.asset(
                    ImagesConstants.fatBorderCircle,
                    height: _redCircleSize.value,
                    width: _redCircleSize.value,
                    colorFilter: ColorFilter.mode(
                      AppColors.nearBlue.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                crossFadeState: _getCrossFadeStates(),
                duration: const Duration(
                  milliseconds: 200,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  CrossFadeState _getCrossFadeStates() {
    if (_sizeAndRotateAnimationController.isCompleted &&
        _sizeAndRotateAnimationController.value < 0.6) {
      return CrossFadeState.showFirst;
    } else if (_sizeAndRotateAnimationController.value < 0.4) {
      return CrossFadeState.showFirst;
    }
    return CrossFadeState.showSecond;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _sizeAndRotateAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) => _onBlocListener(state),
      builder: (context, state) => _redCircle(),
    );
  }
}
