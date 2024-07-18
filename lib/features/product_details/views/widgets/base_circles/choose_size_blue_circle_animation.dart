import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/num_constants.dart';
import '../../../../../core/utils/custom_curves.dart';
import '../../../../home/cubit/home_animation_cubit.dart';
import '../../../cubit/product_details_cubit.dart';
import 'body_choose_size_blue_circle_animation.dart';

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
                  position: _blueCircleSlide,
                  child: Transform.rotate(
                    alignment: Alignment.center,
                    angle: _rotateAnimation.value,
                    child: BodyChooseSizeBlueCircleAnimation(
                      adaptiveCurve: _adaptiveCurve,
                      productCubit: _productCubit,
                      isChangeCircleFromMediumToSmall: _isChangeCircleFromMediumToSmall,
                      isChangeCircleFromMediumToMedium: _isChangeCircleFromMediumToMedium,
                      isChangeCircleFromSmallToMedium: _isChangeCircleFromSmallToMedium,
                      isChangeCircleFromMediumToLarge: _isChangeCircleFromMediumToLarge,
                      isChangeCircleFromLargeToMedium: _isChangeCircleFromLargeToMedium,
                      isChangeCircleFromLargeToSmall: _isChangeCircleFromLargeToSmall,
                      isChangeCircleFromSmallToLarge: _isChangeCircleFromSmallToLarge,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _handelAnimationController(ProductDetailsState state) async {
    if (_productCubit.isStartChooseSizeAnimation) {
      isBackToProductDetailsView = false;
      _rotateAnimation = Tween<double>(
        begin: 0,
        end: -2.1,
      ).animate(_adaptiveCurve);
      await _animationController.forward();
    } else if (_productCubit.isReversChooseSizeAnimation) {
      _handleReversAnimationController();
    }
  }

  void _handleReversAnimationController() async {
    if (_chooseSizeAnimationController.isCompleted &&
        _productCubit.productDetailsSizeEnum != ProductDetailsSizeEnum.medium) {
      _productCubit.productDetailsSizeEnum == ProductDetailsSizeEnum.small
          ? reversIsSizeSmall()
          : reversIsNotSizeSmall();
    } else {
      _animationController
          .reverse()
          .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
    }
  }

  void reversIsSizeSmall() {
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: -2.1,
    ).animate(defaultCurve);
    _chooseSizeAnimationController.reverse();
    _animationController
        .reverse()
        .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
  }

  void reversIsNotSizeSmall() {
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: -1.5,
    ).animate(defaultCurve);
    _chooseSizeAnimationController.reverse();
    _animationController
        .reverse()
        .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
  }

  void _handleChooseSizeAnimationController() {
    final historySizeList = _productCubit.historySizeList;
    final lastSize = historySizeList.isNotEmpty ? historySizeList.last : null;

    if (_isChangeCircleFromLargeToSmall && lastSize != ProductDetailsSizeEnum.small) {
      if (lastSize != ProductDetailsSizeEnum.small) {
        _rotateAnimation = Tween<double>(begin: -2.1, end: -1.3).animate(_adaptiveCurve);
      }
    } else if (_isChangeCircleFromLargeToMedium) {
      if (lastSize == ProductDetailsSizeEnum.medium ||
          lastSize == ProductDetailsSizeEnum.small) {
        _rotateAnimation = Tween<double>(begin: -1.3, end: 0).animate(_adaptiveCurve);
      } else {
        _rotateAnimation = Tween<double>(begin: 0, end: -1.3).animate(_adaptiveCurve);
      }
      _chooseSizeAnimationController.reset();
    } else if (_isChangeCircleFromSmallToMedium) {
      _rotateAnimation = Tween<double>(begin: -2.1, end: 0).animate(_adaptiveCurve);
      _chooseSizeAnimationController.reset();
    } else if (_isChangeCircleFromMediumToLarge) {
      _chooseSizeAnimationController.reset();

      _rotateAnimation = Tween<double>(begin: 0, end: -1.3).animate(_adaptiveCurve);
    } else if (_isChangeCircleFromMediumToSmall) {
      _chooseSizeAnimationController.reset();

      if (lastSize == ProductDetailsSizeEnum.large) {
        _rotateAnimation = Tween<double>(begin: 0, end: -2.1).animate(_adaptiveCurve);
      } else {
        _rotateAnimation = Tween<double>(begin: 0, end: -2.1).animate(_adaptiveCurve);
      }
    } else if (_isChangeCircleFromSmallToLarge) {
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

  bool get _isChangeCircleFromSmallToLarge {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.large);
  }

  bool get _isChangeCircleFromSmallToMedium {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.medium);
  }

  bool get _isChangeCircleFromLargeToSmall {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.small);
  }

  bool get _isChangeCircleFromLargeToMedium {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.medium);
  }

  bool get _isChangeCircleFromMediumToSmall {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.small);
  }

  bool get _isChangeCircleFromMediumToLarge {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.large);
  }

  bool get _isChangeCircleFromMediumToMedium {
    return _productCubit.getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.medium);
  }

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
