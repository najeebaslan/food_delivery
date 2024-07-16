import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/features/home/cubit/home_animation_cubit.dart';
import 'package:food_delivery/features/product_details/views/widgets/base_circles/hero_blue_circle_product.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../../../cubit/product_details_cubit.dart';

class ChooseSizeBlueCircleAnimation extends StatefulWidget {
  const ChooseSizeBlueCircleAnimation({super.key});

  @override
  State<ChooseSizeBlueCircleAnimation> createState() =>
      _ChooseSizeBlueCircleAnimationState();
}

class _ChooseSizeBlueCircleAnimationState extends State<ChooseSizeBlueCircleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _chooseSizeAnimationController;
  late ProductDetailsCubit _productCubit;

  bool isBackToProductDetailsView = false;
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) => _onBlocListener(state),
      builder: (context, state) => _blueCircle(),
    );
  }

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
    if (!_chooseSizeAnimationController.isCompleted) {
      _chooseSizeAnimationController.forward();
    } else {
      _chooseSizeAnimationController.reverse();
    }
  }

  List<Widget> listWidget([double? colorOpacity]) => [
        Transform.rotate(
          alignment: Alignment.center,
          angle: Tween<double>(
            begin: 0,
            end: -2.1,
          ).animate(_adaptiveCurve).value,
          child: HeroBlueCircleProduct(
            parameters: HeroRedCircleParameters(
              showProductDetails: _productCubit.isProductDetailsVisible,
              width: 195.02.w,
              height: 195.02.h,
              angle: 4,
              color: AppColors.blue.withOpacity(
                _productCubit.getOldAndCurrentSize ==
                        (
                          ProductDetailsSizeEnum.medium,
                          ProductDetailsSizeEnum.medium,
                        )
                    ? 1.0
                    : colorOpacity ?? _blueCircleOpacity.value.clamp(0.0, 1.0),
              ),
              animatedBuilderChildAngle: (animationValue) {
                return animationValue > 1 ? 4 : 3;
              },
            ),
          ),
        ),
        Transform.rotate(
          alignment: Alignment.center,
          angle: Tween<double>(
            begin: 0,
            end: -2.1,
          ).animate(_adaptiveCurve).value,
          child: Transform.rotate(
            angle: 2,
            child: SvgPicture.asset(
              ImagesConstants.chooseSizeGreenCircle,
              width: 185.02.w,
              height: 185.02.h,
              colorFilter: ColorFilter.mode(
                AppColors.green.withOpacity(
                  colorOpacity ?? _greenCircleOpacity.value.clamp(0.0, 1.0),
                ),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),

        Transform.rotate(
          angle: 1.5,
          child: SvgPicture.asset(
            ImagesConstants.chooseSizeYellowCircle,
            width: 195.02.w,
            height: 195.02.h,
            colorFilter: ColorFilter.mode(
              AppColors.yellow.withOpacity(
                colorOpacity ?? _yellowCircleOpacity.value.clamp(0.0, 1.0),
              ),
              BlendMode.srcIn,
            ),
          ),
        )
        // :
        // Transform.rotate(
        //     alignment: Alignment.center,
        //     angle: Tween<double>(
        //       begin: 0,
        //       end: -2.1,
        //     ).animate(_adaptiveCurve).value,
        //     child: Transform.rotate(
        //       angle: 1.5,
        //       child: SvgPicture.asset(
        //         ImagesConstants.chooseSizeYellowCircle,
        //         width: 195.02.w,
        //         height: 195.02.h,
        //         colorFilter: ColorFilter.mode(
        //           AppColors.yellow.withOpacity(
        //             colorOpacity ?? _yellowCircleOpacity.value.clamp(0.0, 1.0),
        //           ),
        //           BlendMode.srcIn,
        //         ),
        //       ),
        //     ),
        //   ),
      ];
  Widget _blueCircle() {
    return BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: Listenable.merge([
            _animationController,
            _chooseSizeAnimationController,
          ]),
          builder: (context, child) {
            log(_productCubit.getOldAndCurrentSize.toString());
            return SlideTransition(
              position: _blueCircleSlide,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_productCubit.getOldAndCurrentSize ==
                      (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.small)) ...[
                    listWidget()[1],
                    listWidget(_circleOpacity.value.clamp(0.0, 1.0))[0]
                  ] else if (_productCubit.getOldAndCurrentSize ==
                      (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.small)) ...[
                    listWidget(_circleOpacity.value.clamp(0.0, 1.0))[2],
                    listWidget()[1],
                  ] else if (_productCubit.getOldAndCurrentSize ==
                      (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.large)) ...[
                    listWidget()[1],
                    Transform.rotate(
                        alignment: Alignment.center,
                        angle: Tween<double>(
                          begin: 0,
                          end: 1.1,
                        ).animate(_adaptiveCurve).value,
                        child: Transform.rotate(
                            angle: 4.8,
                            child: listWidget(_circleOpacity.value.clamp(0.0, 1.0))[2])),
                  ] else if (_productCubit.getOldAndCurrentSize ==
                      (
                        ProductDetailsSizeEnum.medium,
                        ProductDetailsSizeEnum.large,
                      )) ...[
                    listWidget(_circleOpacity.value.clamp(0.0, 1.0))[0],
                    listWidget()[2],
                  ] else if (_productCubit.getOldAndCurrentSize ==
                      (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.medium)) ...[
                    listWidget()[2],
                    listWidget(_circleOpacity.value.clamp(0.0, 1.0))[0],
                  ] else if (_productCubit.getOldAndCurrentSize ==
                      (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.medium)) ...[
                    listWidget()[1],
                    listWidget(_circleOpacity.value.clamp(0.0, 1.0))[0],
                  ] else if (_productCubit.getOldAndCurrentSize ==
                      (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.medium))
                    listWidget()[0],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Animation<double> get _greenCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);
  Animation<double> get _circleOpacity =>
      Tween(begin: 1.0, end: 0.0).animate(_adaptiveCurve);

  Animation<double> get _yellowCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);

  Animation<double> get _blueCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);

  Animation<Offset> get _blueCircleSlide =>
      Tween<Offset>(begin: Offset.zero, end: const Offset(1.2, -0.65))
          .animate(_defaultCurve);

  CurvedAnimation get _defaultCurve => CurvedAnimation(
        parent: _animationController,
        curve: easeInOutBackSlow50,
      );

  CurvedAnimation get _adaptiveCurve {
    return CurvedAnimation(
      parent: isBackToProductDetailsView
          ? _animationController
          : _chooseSizeAnimationController,
      curve: easeInOutBackSlow50,
    );
  }
}
