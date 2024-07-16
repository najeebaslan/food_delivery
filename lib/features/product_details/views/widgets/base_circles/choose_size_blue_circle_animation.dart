import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/features/home/blocs/home_animation_cubit/home_animation_cubit.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../../../product_details_cubit/product_details_cubit.dart';
import 'hero_blue_circle_product.dart';

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
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
      builder: (context, state) {
        return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (context, state) => _onBlocListener(state),
          builder: (context, state) => _blueCircle(),
        );
      },
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

  Widget _blueCircle() {
    return BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: Listenable.merge([
            _animationController,
            _chooseSizeAnimationController,
          ]),
          builder: (context, child) {
            return SlideTransition(
              position: _blueCircleSlide,
              child: Transform.rotate(
                alignment: Alignment.center,
                angle: Tween<double>(
                  begin: 0,
                  end: 1.0,
                ).animate(_adaptiveCurve).value,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: 0.8,
                      child: SvgPicture.asset(
                        ImagesConstants.onboardingCircleRed,
                        width: 185.02.w,
                        height: 185.02.h,
                        colorFilter: ColorFilter.mode(
                          AppColors.green.withOpacity(
                            _circleOpacity.value.clamp(0.0, 1.0),
                          ),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    HeroBlueCircleProduct(
                      parameters: HeroRedCircleParameters(
                        showProductDetails: _productCubit.isProductDetailsVisible,
                        width: 119095.02.w,
                        height: 195.02.h,
                        angle: 4,
                        color: AppColors.blue.withOpacity(
                          _blueCircleOpacity.value.clamp(0.0, 1.0),
                        ),
                        animatedBuilderChildAngle: (animationValue) {
                          return animationValue > 1 ? 4 : 3;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     // yellow Circle
              //     Positioned(
              //       child: SvgPicture.asset(
              //         ImagesConstants.onboardingCircleRed,
              //         width: 195.02.w,
              //         height: 195.02.h,
              //         colorFilter: ColorFilter.mode(
              //           AppColors.yellow.withOpacity(
              //             _circleOpacity.value.clamp(0.0, 1.0),
              //           ),
              //           BlendMode.srcIn,
              //         ),
              //       ),
              //     ),
              //     // green circle
              //     Positioned(
              //       child: SvgPicture.asset(
              //         ImagesConstants.onboardingCircleRed,
              //         width: 195.02.w,
              //         height: 195.02.h,
              //         colorFilter: ColorFilter.mode(
              //           AppColors.green.withOpacity(
              //             _circleOpacity.value.clamp(0.0, 1.0),
              //           ),
              //           BlendMode.srcIn,
              //         ),
              //       ),
              //     ),
              //     // blue circle

              //     Positioned(
              //       child: HeroBlueCircleProduct(
              //         parameters: HeroRedCircleParameters(
              //           showProductDetails: _productCubit.isProductDetailsVisible,
              //           height: 195.023.h,
              //           width: 195.023.w,
              //           angle: 4,
              //           color: AppColors.blue.withOpacity(
              //             _blueCircleOpacity.value.clamp(0.0, 1.0),
              //           ),
              //           animatedBuilderChildAngle: (animationValue) {
              //             return animationValue > 1 ? 4 : 3;
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            );
          },
        );
      },
    );
  }

  Animation<double> get _circleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);

  Animation<double> get _blueCircleOpacity =>
      Tween(begin: 1.0, end: 0.0).animate(_adaptiveCurve);

  Animation<Offset> get _blueCircleSlide =>
      Tween<Offset>(begin: Offset.zero, end: const Offset(1.2, -0.65))
          .animate(_defaultCurve);

  CurvedAnimation get _defaultCurve =>
      CurvedAnimation(parent: _animationController, curve: easeInOutBackSlow50);

  CurvedAnimation get _adaptiveCurve {
    return CurvedAnimation(
      parent: isBackToProductDetailsView
          ? _animationController
          : _chooseSizeAnimationController,
      curve: Curves.easeInOutBack,
    );
  }
}
