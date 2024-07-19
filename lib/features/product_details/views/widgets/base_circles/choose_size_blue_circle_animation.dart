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
      end: -2,
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
        end: -2,
      ).animate(_adaptiveCurve);
      await _animationController.forward();
    } else if (_productCubit.isReversChooseSizeAnimation) {
      _handleReversAnimationController();
    }
  }

  void _handleReversAnimationController() async {
    if (_isCompletedAnimationAndIsMediumSize) {
      _productCubit.productDetailsSizeEnum == ProductDetailsSizeEnum.small
          ? _reversAnimationWhenSizeIsSmall()
          : _reversAnimationWhenSizeIsNotSmall();
    } else {
      _animationController
          .reverse()
          .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
    }
  }

  bool get _isCompletedAnimationAndIsMediumSize =>
      _chooseSizeAnimationController.isCompleted &&
      _productCubit.productDetailsSizeEnum != ProductDetailsSizeEnum.medium;

  void _reversAnimationWhenSizeIsSmall() {
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: -2,
    ).animate(defaultCurve);
    _chooseSizeAnimationController.reverse();
    _animationController
        .reverse()
        .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
  }

  void _reversAnimationWhenSizeIsNotSmall() {
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

    if (_productCubit.isChangeCircleFromLargeToSmall &&
        lastSize != ProductDetailsSizeEnum.small) {
      if (lastSize != ProductDetailsSizeEnum.small) {
        _rotateAnimation = Tween<double>(begin: -2, end: -1.3).animate(_adaptiveCurve);
      }
    } else if (_productCubit.isChangeCircleFromLargeToMedium) {
      if (lastSize == ProductDetailsSizeEnum.medium ||
          lastSize == ProductDetailsSizeEnum.small) {
        _rotateAnimation = Tween<double>(begin: -1.3, end: 0).animate(_adaptiveCurve);
      } else {
        _rotateAnimation = Tween<double>(begin: 0, end: -1.3).animate(_adaptiveCurve);
      }
      _chooseSizeAnimationController.reset();
    } else if (_productCubit.isChangeCircleFromSmallToMedium) {
      _rotateAnimation = Tween<double>(begin: -2, end: 0).animate(_adaptiveCurve);
      _chooseSizeAnimationController.reset();
    } else if (_productCubit.isChangeCircleFromMediumToLarge) {
      _chooseSizeAnimationController.reset();

      _rotateAnimation = Tween<double>(begin: 0, end: -1.3).animate(_adaptiveCurve);
    } else if (_productCubit.isChangeCircleFromMediumToSmall) {
      _chooseSizeAnimationController.reset();

      if (lastSize == ProductDetailsSizeEnum.large) {
        _rotateAnimation = Tween<double>(begin: 0, end: -2).animate(_adaptiveCurve);
      } else {
        _rotateAnimation = Tween<double>(begin: 0, end: -2).animate(_adaptiveCurve);
      }
    } else if (_productCubit.isChangeCircleFromSmallToLarge) {
      if (lastSize != ProductDetailsSizeEnum.large) {
        _rotateAnimation = Tween<double>(begin: -1.3, end: -2).animate(_adaptiveCurve);
      }
    }

    if (!_chooseSizeAnimationController.isCompleted) {
      _chooseSizeAnimationController.forward();
    } else {
      _chooseSizeAnimationController.reverse();
    }
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
