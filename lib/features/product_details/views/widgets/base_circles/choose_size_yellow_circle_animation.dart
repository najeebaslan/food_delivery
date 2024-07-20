import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/styles/app_colors.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/hero_tags_constants.dart';
import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../../core/utils/custom_rect_tween.dart';
import '../../../cubit/product_details_cubit.dart';

class ChooseSizeYellowCircleAnimation extends StatefulWidget {
  const ChooseSizeYellowCircleAnimation({super.key});

  @override
  State<ChooseSizeYellowCircleAnimation> createState() =>
      _ChooseSizeYellowCircleAnimationState();
}

class _ChooseSizeYellowCircleAnimationState extends State<ChooseSizeYellowCircleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _chooseSizeAnimationController;
  late Animation<Offset> _yellowCirclePosition;

  late Animation<double> _yellowCircleOpacity;
  late Animation<double> _yellowCircleSize;
  late Animation<double> _yellowCircleRotate;
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

    _initializeAnimations();
  }

  void _initializeAnimations() {
    _yellowCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.95),
    ).animate(_defaultCurve);

    _yellowCircleSize = Tween<double>(
      begin: 78.358,
      end: 116.305,
    ).animate(_defaultCurve);

    _yellowCircleRotate = Tween<double>(
      begin: 0,
      end: -0.7,
    ).animate(_defaultCurve);

    _yellowCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.15,
    ).animate(_defaultCurve);
  }

  void _handleChooseSizeAnimationController() {
    final historySizeList = _productCubit.historySizeList;
    final lastSize = historySizeList.isNotEmpty ? historySizeList.last : null;

    // if (_productCubit.isChangeCircleFromLargeToSmall) {
    // _chooseSizeAnimationController.reset();

    // if (lastSize != ProductDetailsSizeEnum.small) {
    //   _yellowCircleRotate = Tween<double>(
    //     begin: -2,
    //     end: -1.3,
    //   ).animate(_adaptiveCurve);
    // }
    // } else
    if (_productCubit.isChangeCircleFromLargeToMedium) {
      if (lastSize == ProductDetailsSizeEnum.medium ||
          lastSize == ProductDetailsSizeEnum.small) {
        _yellowCircleSize = Tween<double>(
          begin: 170.69,
          end: 116.305,
        ).animate(_adaptiveCurve);

        _yellowCircleRotate = Tween<double>(
          begin: -3.4,
          end: -0.7,
        ).animate(_adaptiveCurve);
      } else {
        _yellowCircleRotate = Tween<double>(
          begin: -0.7,
          end: -3.4,
        ).animate(_adaptiveCurve);
      }
      _chooseSizeAnimationController.reset();
    } else if (_productCubit.isChangeCircleFromSmallToMedium) {
      _yellowCircleSize = Tween<double>(
        begin: 170.69,
        end: 116.305,
      ).animate(_adaptiveCurve);
      _yellowCircleRotate = Tween<double>(
        begin: -3.4,
        end: -0.7,
      ).animate(_adaptiveCurve);
      _chooseSizeAnimationController.reset();
    } else if (_productCubit.isChangeCircleFromMediumToLarge) {
      _chooseSizeAnimationController.reset();
      _yellowCircleSize = Tween<double>(
        begin: 116.305,
        end: 170.69,
      ).animate(_adaptiveCurve);
      _yellowCircleRotate = Tween<double>(
        begin: -0.7,
        end: -3.4,
      ).animate(_adaptiveCurve);
    } else if (_productCubit.isChangeCircleFromMediumToSmall) {
      _chooseSizeAnimationController.reset();
      _yellowCircleSize = Tween<double>(
        begin: 116.305,
        end: 170.69,
      ).animate(_adaptiveCurve);
      _yellowCircleRotate = Tween<double>(
        begin: -0.7,
        end: -3.4,
      ).animate(_adaptiveCurve);
    }

    if (isLargeToSmallFromMedium) {
      _yellowCircleSize = Tween<double>(
        begin: 170.69,
        end: 116.305,
      ).animate(_adaptiveCurve);
    }
   
    if (!_chooseSizeAnimationController.isCompleted) {
      _chooseSizeAnimationController.forward();
    } else {
      _chooseSizeAnimationController.reverse();
    }
  }

  bool get shouldNotRunRotation =>
      _productCubit.isChangeCircleFromSmallToLarge ||
      _productCubit.isChangeCircleFromLargeToSmall;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is ChangeStateAnimation) {
          _handelAnimationController(state);
        }
        if (state is ProductDetailsSizeChanged) {
          _handleChooseSizeAnimationController();
        }
      },
      builder: (context, state) {
        return AnimatedBuilder(
          animation: Listenable.merge([
            _animationController,
            _chooseSizeAnimationController,
          ]),
          builder: (context, child) {
            return SlideTransition(
              position: _yellowCirclePosition,
              child: Transform.rotate(
                angle: shouldNotRunRotation ? -3.4 : _yellowCircleRotate.value,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    _yellowCircle(
                      manageYellowColor(),
                    ),
                    Transform.rotate(
                      alignment: Alignment.topCenter,
                      angle: 3.5,
                      child: Transform.translate(
                        offset: (shouldNotRunRotation || isLargeToSmallFromMedium) ||
                                isSmallToLargeFromLarge
                            ? Offset(-20.w, -10.h)
                            : Offset(20.w, 40.h),
                        child: SvgPicture.string(
                          '''<svg xmlns="http://www.w3.org/2000/svg" width="33" height="61" viewBox="0 0 33 61" fill="none">
                                <path opacity="0.1" d="M0.940932 42.2441C0.751982 53.3659 9.73283 62.7723 20.5905 60.3556C31.4482 57.939 35.5916 45.6115 30.7033 35.6198L15.2439 4.02051C13.8525 1.17639 10.4171 0.0741524 7.32649 0.762049C4.23586 1.44994 1.59228 3.90519 1.53849 7.07099L0.940932 42.2441Z" fill="#FABB2D"/>
                              </svg>''',
                          colorFilter: ColorFilter.mode(
                            AppColors.yellow.withOpacity(
                              mangeOpacityColorForSmallYellowShape(),
                            ),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  double mangeOpacityColorForSmallYellowShape() {
    if (_productCubit.isChangeCircleFromSmallToLarge &&
        _productCubit.historySizeList.last == ProductDetailsSizeEnum.large) {
      return greenCircleOpacity.value.clamp(0.0, 1.0);
    } else if (isLargeToSmallFromMedium) {
      return greenCircleOpacity.value.clamp(0.0, 1.0);
    } else {
      return _productCubit.isChangeCircleFromLargeToMedium ||
              _productCubit.isChangeCircleFromLargeToSmall ||
              _productCubit.isChangeCircleFromSmallToLarge
          ? circleOpacity.value.clamp(0.0, 1.0)
          : _productCubit.isChangeCircleFromMediumToLarge
              ? greenCircleOpacity.value.clamp(0.0, 1.0)
              : 0;
    }
  }

  double? manageYellowColor() {
    if (_productCubit.isChangeCircleFromSmallToLarge &&
        _productCubit.historySizeList.last == ProductDetailsSizeEnum.large) {
      return circleOpacity.value.clamp(0.0, 1.0);
    } else if (_productCubit.isChangeCircleFromLargeToSmall &&
        _productCubit.historySizeList.last == ProductDetailsSizeEnum.medium) {
      return circleOpacity.value.clamp(0.0, 1.0);
    } else {
      return _productCubit.isChangeCircleFromLargeToMedium ||
              _productCubit.isChangeCircleFromLargeToSmall ||
              _productCubit.isChangeCircleFromSmallToLarge
          ? greenCircleOpacity.value.clamp(0.0, 1.0)
          : _productCubit.isChangeCircleFromMediumToLarge
              ? circleOpacity.value.clamp(0.0, 1.0)
              : null;
    }
  }

  bool get isLargeToSmallFromMedium {
    return _productCubit.isChangeCircleFromLargeToSmall &&
        _productCubit.historySizeList.last == ProductDetailsSizeEnum.medium;
  }

  bool get isSmallToLargeFromLarge {
    return _productCubit.isChangeCircleFromSmallToLarge &&
        _productCubit.historySizeList.last == ProductDetailsSizeEnum.large;
  }

  void _handelAnimationController(ProductDetailsState state) async {
    if (_productCubit.isStartChooseSizeAnimation) {
      isBackToProductDetailsView = false;

      _animationController.forward();
    } else if (_productCubit.isReversChooseSizeAnimation) {
      _handleReversAnimationController();
    }
  }

  void _handleReversAnimationController() async {
    if (_chooseSizeAnimationController.isCompleted &&
        _productCubit.productDetailsSizeEnum != ProductDetailsSizeEnum.medium) {
      _productCubit.productDetailsSizeEnum == ProductDetailsSizeEnum.small
          ? _reversAnimationWhenSizeIsSmall()
          : _reversAnimationWhenSizeIsNotSmall();
    } else {
      _animationController
          .reverse()
          .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
    }
  }

  void _reversAnimationWhenSizeIsSmall() {
    _yellowCircleRotate = Tween<double>(
      begin: 0,
      end: -2,
    ).animate(_defaultCurve);
    _chooseSizeAnimationController.reverse();
    _animationController
        .reverse()
        .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
  }

  void _reversAnimationWhenSizeIsNotSmall() {
    _yellowCircleRotate = Tween<double>(
      begin: 0,
      end: -1.5,
    ).animate(_defaultCurve);
    _chooseSizeAnimationController.reverse();
    _animationController
        .reverse()
        .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
  }

  Widget _yellowCircle([double? colorValue]) {
    return Hero(
      tag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
      createRectTween: (begin, end) {
        return CustomRectTween(
          begin: begin!,
          end: end!,
        );
      },
      child: FadeTransition(
        opacity: _yellowCircleOpacity,
        child: SvgPicture.string(
          SVGImageConstants.yellowCircle,
          height: _yellowCircleSize.value.h,
          width: _yellowCircleSize.value.w,
          colorFilter: colorValue != null
              ? ColorFilter.mode(
                  AppColors.yellow.withOpacity(colorValue),
                  BlendMode.srcIn,
                )
              : null,
        ),
      ),
    );
  }

  CurvedAnimation get _adaptiveCurve {
    return CurvedAnimation(
      parent: isBackToProductDetailsView
          ? _animationController
          : _chooseSizeAnimationController,
      curve: easeInOutBackSlow50,
    );
  }

  CurvedAnimation get _defaultCurve => CurvedAnimation(
        parent: _animationController,
        curve: easeInOutBackSlow50,
      );
  Animation<double> get greenCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);

  Animation<double> get circleOpacity =>
      Tween(begin: 1.0, end: 0.0).animate(_adaptiveCurve);
}
