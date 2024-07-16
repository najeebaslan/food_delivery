import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/num_constants.dart';
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
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _blueCirclePosition;
  late ProductDetailsCubit _productCubit;

  late final curve = CurvedAnimation(
    parent: _animationController,
    curve: easeInOutBackSlow30,
    reverseCurve: easeInOutBackSlow30,
  );

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
    _blueCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.2, -0.65),
    ).animate(curve);
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
      },
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return _blueCircle();
          },
        );
      },
    );
  }

  Widget _blueCircle() {
    return SlideTransition(
      position: _blueCirclePosition,
      child: HeroBlueCircleProduct(
        parameters: HeroRedCircleParameters(
          showProductDetails: _productCubit.isProductDetailsVisible,
          height: 195.023.h,
          width: 195.023.w,
          angle: 4,
          animatedBuilderChildAngle: (animationValue) {
            return animationValue > 1 ? 4 : 3;
          },
        ),
      ),
    );
  }
}
