import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  late final curve = CurvedAnimation(
    parent: _animationController,
    curve: easeInOutBackSlow50,
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
    _chooseSizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration900,
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

  void _handleChooseSizeAnimationController() {
    final historySizeList = _productCubit.historySizeList;
    final lastSize = historySizeList.isNotEmpty ? historySizeList.last : null;

    if (_productCubit.isChangeCircleFromLargeToSmall) {
      if (lastSize != ProductDetailsSizeEnum.small) {
        _yellowCircleRotate = Tween<double>(
          begin: -2.1,
          end: -1.3,
        ).animate(_adaptiveCurve);
      }
    } else if (_productCubit.isChangeCircleFromLargeToMedium) {
      if (lastSize == ProductDetailsSizeEnum.medium ||
          lastSize == ProductDetailsSizeEnum.small) {
        _yellowCircleRotate = Tween<double>(
          begin: -1.3,
          end: 0,
        ).animate(_adaptiveCurve);
      } else {
        _yellowCircleRotate = Tween<double>(
          begin: 0,
          end: -1.3,
        ).animate(_adaptiveCurve);
      }
      _chooseSizeAnimationController.reset();
    } else if (_productCubit.isChangeCircleFromSmallToMedium) {
      _yellowCircleSize = Tween<double>(
        begin: 170.69,
        end: 116.305,
      ).animate(_adaptiveCurve);
      _yellowCircleRotate = Tween<double>(
        begin: -3.1,
        end: -0.7,
      ).animate(_adaptiveCurve);
      _chooseSizeAnimationController.reset();
    } else if (_productCubit.isChangeCircleFromMediumToLarge) {
      _chooseSizeAnimationController.reset();

      _yellowCircleRotate = Tween<double>(
        begin: 0,
        end: -1.3,
      ).animate(_adaptiveCurve);
    } else if (_productCubit.isChangeCircleFromMediumToSmall) {
      _chooseSizeAnimationController.reset();
      _yellowCircleSize = Tween<double>(
        begin: 116.305,
        end: 170.69,
      ).animate(_adaptiveCurve);

      if (lastSize == ProductDetailsSizeEnum.large) {
        _yellowCircleRotate = Tween<double>(
          begin: -0.7,
          end: -2.1,
        ).animate(_adaptiveCurve);
      } else {
        _yellowCircleRotate = Tween<double>(
          begin: -0.7,
          end: -3.1,
        ).animate(_adaptiveCurve);
      }
    } else if (_productCubit.isChangeCircleFromSmallToLarge) {
      if (lastSize != ProductDetailsSizeEnum.large) {
        _yellowCircleRotate = Tween<double>(
          begin: -1.3,
          end: -2.1,
        ).animate(_adaptiveCurve);
      }
    }

    if (!_chooseSizeAnimationController.isCompleted) {
      _chooseSizeAnimationController.forward();
    } else {
      _chooseSizeAnimationController.reverse();
    }
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
            return FadeTransition(
              opacity: _yellowCircleOpacity,
              child: SlideTransition(
                position: _yellowCirclePosition,
                child: _yellowCircle(),
              ),
            );
          },
        );
      },
    );
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
          ? reversAnimationWhenSizeIsSmall()
          : reversAnimationWhenSizeIsNotSmall();
    } else {
      _animationController
          .reverse()
          .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
    }
  }

  void reversAnimationWhenSizeIsSmall() {
    _yellowCircleRotate = Tween<double>(
      begin: 0,
      end: -2.1,
    ).animate(defaultCurve);
    _chooseSizeAnimationController.reverse();
    _animationController
        .reverse()
        .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
  }

  void reversAnimationWhenSizeIsNotSmall() {
    _yellowCircleRotate = Tween<double>(
      begin: 0,
      end: -1.5,
    ).animate(defaultCurve);
    _chooseSizeAnimationController.reverse();
    _animationController
        .reverse()
        .whenCompleteOrCancel(() => isBackToProductDetailsView = true);
  }

  Widget _yellowCircle() {
    return Hero(
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

  CurvedAnimation get defaultCurve => CurvedAnimation(
        parent: _animationController,
        curve: easeInOutBackSlow50,
      );
}
