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

class RedCircle extends StatefulWidget {
  const RedCircle({super.key});

  @override
  State<RedCircle> createState() => _RedCircleState();
}

class _RedCircleState extends State<RedCircle> with TickerProviderStateMixin {
  late AnimationController _sizeAndRotateAnimationController;
  late AnimationController _animationController;
  late Animation<Offset> _redCirclePosition;
  late Animation<double> _redCircleOpacity;
  late Animation<double> _redCircleSize;
  late Animation<double> _rotateRedCircle;

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
    _sizeAndRotateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumConstants.duration900),
    );

    _redCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2),
    ).animate(curve);

    _redCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.2,
    ).animate(curve);
    _initSizeRedCircleAnimation(false);
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
      listener: (context, state) {
        if (_productCubit.isStartChooseSizeAnimation) {
          _animationController.forward();
        } else if (_productCubit.isReversChooseSizeAnimation) {
          _animationController.reverse();
        }

        if (state is ProductDetailsSizeChanged) {
          _handleSizeAndRotateAnimation();
        }
      },
      builder: (context, state) => _redCircle(),
    );
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
            position: _redCirclePosition,
            child: Transform.rotate(
              angle: _rotateRedCircle.value,
              alignment: Alignment.center,
              child: AnimatedCrossFade(
                layoutBuilder: (
                  topChild,
                  topChildKey,
                  bottomChild,
                  bottomChildKey,
                ) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        key: topChildKey,
                        child: topChild,
                      ),
                      Positioned(
                        key: bottomChildKey,
                        child: bottomChild,
                      ),
                    ],
                  );
                },
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

  void _handleSizeAndRotateAnimation() {
    if (_sizeAndRotateAnimationController.value == 0) {
      final oldAndCurrentSize = _productCubit.getOldAndCurrentSize;
      if (oldAndCurrentSize ==
              (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.small) ||
          oldAndCurrentSize ==
              (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.small)) {
        _sizeAndRotateAnimationController.forward();
        _initSizeRedCircleAnimation(true);
      } else if (oldAndCurrentSize ==
              (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.large) ||
          oldAndCurrentSize ==
              (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.medium)) {
        _sizeAndRotateAnimationController.reverse();
        _initSizeRedCircleAnimation(false);
      }
    } else {

      _sizeAndRotateAnimationController.reverse();
        _animationController.reverse();
    }
  }

  _initSizeRedCircleAnimation(bool isSmall) {
    _redCircleSize = Tween<double>(
      begin: 48.13,
      end: isSmall ? 70.204 : 48.13,
    ).animate(
      CurvedAnimation(
        parent: _sizeAndRotateAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    _rotateRedCircle = Tween<double>(
      begin: 0,
      end: isSmall ? math.pi : 0,
    ).animate(
      CurvedAnimation(
        parent: _sizeAndRotateAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }
}
