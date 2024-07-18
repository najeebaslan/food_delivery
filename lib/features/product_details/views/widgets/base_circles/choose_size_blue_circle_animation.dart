import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/features/home/cubit/home_animation_cubit.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../../../cubit/product_details_cubit.dart';
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
  late Animation<double> _rotateAnimation;

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

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: -2.1,
    ).animate(_adaptiveCurve);
  }

  @override
  void dispose() {
    _chooseSizeAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
      builder: (context, state) {
        return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (context, state) => onBlocListener(state),
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
                    angle: _rotateAnimation.value,
                    child: blueCircle(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void onBlocListener(ProductDetailsState state) {
    if (state is ChangeStateAnimation) {
      handelAnimationController(state);
    }
    if (state is ProductDetailsSizeChanged) {
      handleChooseSizeAnimationController();
    }
  }

  void handelAnimationController(ProductDetailsState state) async {
    if (_productCubit.isStartChooseSizeAnimation) {
      isBackToProductDetailsView = false;
      _rotateAnimation = Tween<double>(
        begin: 0,
        end: -2.1,
      ).animate(_adaptiveCurve);
      await _animationController.forward();
    } else if (_productCubit.isReversChooseSizeAnimation) {
      if (_chooseSizeAnimationController.isCompleted &&
          _productCubit.productDetailsSizeEnum != ProductDetailsSizeEnum.medium) {
        if (_productCubit.productDetailsSizeEnum != ProductDetailsSizeEnum.small) {
          _rotateAnimation = Tween<double>(
            begin: 0,
            end: -1.7,
          ).animate(defaultCurve);
        } else {
          _rotateAnimation = Tween<double>(
            begin: 0,
            end: -2.1,
          ).animate(defaultCurve);
        }

        _chooseSizeAnimationController.reverse();
        _animationController.reverse().whenCompleteOrCancel(() {
          isBackToProductDetailsView = true;
        });
      } else {
        _animationController.reverse().whenCompleteOrCancel(() {
          isBackToProductDetailsView = true;
        });
      }
    }
  }

  void handleChooseSizeAnimationController() {
    final historySizeList = _productCubit.historySizeList;
    final lastSize = historySizeList.isNotEmpty ? historySizeList.last : null;

    if (isChangeCircleFromLargeToSmall && lastSize != ProductDetailsSizeEnum.small) {
      if (lastSize != ProductDetailsSizeEnum.small) {
        _rotateAnimation = Tween<double>(begin: -2.1, end: -1.3).animate(_adaptiveCurve);
      }
    } else if (isChangeCircleFromLargeToMedium) {
      if (lastSize == ProductDetailsSizeEnum.medium ||
          lastSize == ProductDetailsSizeEnum.small) {
        _rotateAnimation = Tween<double>(begin: -1.3, end: 0).animate(_adaptiveCurve);
      } else {
        _rotateAnimation = Tween<double>(begin: 0, end: -1.3).animate(_adaptiveCurve);
      }
      _chooseSizeAnimationController.reset();
    } else if (isChangeCircleFromSmallToMedium) {
      _rotateAnimation = Tween<double>(begin: -2.1, end: 0).animate(_adaptiveCurve);
      _chooseSizeAnimationController.reset();
    } else if (isChangeCircleFromMediumToLarge) {
      _chooseSizeAnimationController.reset();

      _rotateAnimation = Tween<double>(begin: 0, end: -1.3).animate(_adaptiveCurve);
    } else if (isChangeCircleFromMediumToSmall) {
      _chooseSizeAnimationController.reset();

      if (lastSize == ProductDetailsSizeEnum.large) {
        _rotateAnimation = Tween<double>(begin: 0, end: -2.1).animate(_adaptiveCurve);
      } else {
        _rotateAnimation = Tween<double>(begin: 0, end: -2.1).animate(_adaptiveCurve);
      }
    } else if (isChangeCircleFromSmallToLarge) {
      if (lastSize != ProductDetailsSizeEnum.large) {
        _rotateAnimation = Tween<double>(begin: -1.3, end: -2.1).animate(_adaptiveCurve);
      }
    }

    if (!_chooseSizeAnimationController.isCompleted) {
      _chooseSizeAnimationController.forward();
    } else {
      _chooseSizeAnimationController.reverse();
    }
  }

  List<Widget> listWidget([double? colorOpacity]) => [
        HeroBlueCircleProduct(
          parameters: HeroRedCircleParameters(
            showProductDetails: _productCubit.isProductDetailsVisible,
            width: 195.02.w,
            height: 195.02.h,
            angle: 4,
            color: isChangeCircleFromMediumToMedium
                ? AppColors.blue
                : AppColors.blue.withOpacity(
                    colorOpacity ?? blueCircleOpacity.value.clamp(0.0, 1.0),
                  ),
          ),
        ),
        Transform.rotate(
          angle: 2,
          child: SvgPicture.asset(
            ImagesConstants.chooseSizeGreenCircle,
            width: 189.02.w,
            height: 189.02.h,
            colorFilter: ColorFilter.mode(
              AppColors.green.withOpacity(
                colorOpacity ?? greenCircleOpacity.value.clamp(0.0, 1.0),
              ),
              BlendMode.srcIn,
            ),
          ),
        ),
        Transform.rotate(
          angle: 1.3,
          child: SvgPicture.asset(
            ImagesConstants.chooseSizeYellowCircle,
            width: 190.02.w,
            height: 193.02.h,
            colorFilter: ColorFilter.mode(
              AppColors.yellow.withOpacity(
                colorOpacity ??
                    yellowCircleOpacity.value.clamp(
                      0.0,
                      1.0,
                    ),
              ),
              BlendMode.srcIn,
            ),
          ),
        )
      ];
  Widget blueCircle() {
    final historySizeList = _productCubit.historySizeList;

    final lastSize = historySizeList.isNotEmpty ? historySizeList.last : null;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (isChangeCircleFromMediumToSmall) ...[
          listWidget()[1],
          listWidget(circleOpacity.value.clamp(0.0, 1.0))[0]
        ] else if (isChangeCircleFromSmallToMedium) ...[
          listWidget(circleOpacity.value.clamp(0.0, 1.0))[1],
          listWidget()[0],
        ] else if (isChangeCircleFromMediumToLarge) ...[
          listWidget()[2],
          listWidget(circleOpacity.value.clamp(0.0, 1.0))[0],
        ] else if (isChangeCircleFromLargeToMedium) ...[
          listWidget(circleOpacity.value.clamp(0.0, 1.0))[2],
          listWidget()[0],
        ] else if (isChangeCircleFromLargeToSmall) ...[
          listWidget()[2],
          listWidget(circleOpacity.value.clamp(0.0, 1.0))[1],
        ] else if (isChangeCircleFromSmallToLarge) ...[
          if (lastSize == ProductDetailsSizeEnum.medium) ...[
            listWidget()[1],
            listWidget(circleOpacity.value.clamp(0.0, 1.0))[2],
          ] else ...[
            listWidget(circleOpacity.value.clamp(0.0, 1.0))[1],
            listWidget()[2],
          ]
        ] else
          listWidget()[0],
      ],
    );
  }

  bool get isChangeCircleFromSmallToLarge {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.large);
  }

  bool get isChangeCircleFromSmallToMedium {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.medium);
  }

  bool get isChangeCircleFromLargeToSmall {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.small);
  }

  bool get isChangeCircleFromLargeToMedium {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.medium);
  }

  bool get isChangeCircleFromMediumToSmall {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.small);
  }

  bool get isChangeCircleFromMediumToLarge {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.large);
  }

  bool get isChangeCircleFromMediumToMedium {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.medium);
  }

  Animation<double> get greenCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);
  Animation<double> get circleOpacity =>
      Tween(begin: 1.0, end: 0.0).animate(_adaptiveCurve);

  Animation<double> get yellowCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);

  Animation<double> get blueCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(_adaptiveCurve);

  Animation<Offset> get _blueCircleSlide {
    return Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.2, -0.65),
    ).animate(defaultCurve);
  }

  CurvedAnimation get defaultCurve => CurvedAnimation(
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
