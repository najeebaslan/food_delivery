import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

import '../../../core/styles/app_colors.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  static ProductDetailsCubit get(BuildContext context) => BlocProvider.of(context);

  ProductDetailsCubit() : super(ProductDetailsInitial());

  late AnimationController animationController;
  // Circles Positions
  late Animation<Offset> blueCirclePosition;
  late Animation<Offset> yellowCirclePosition;
  late Animation<Offset> redCirclePosition;

  // Circles Opacity
  late Animation<double> yellowCircleOpacity;
  late Animation<double> titleProductOpacity;
  late Animation<double> textChooseSizeOpacity;
  late Animation<double> redCircleOpacity;

  // Circles Size
  late Animation<double> yellowCircleSize;

  // Circles Rotate
  late Animation<double> yellowCircleRotate;
  late Animation backgroundColorAnimation;

  bool isProductDetailsVisible = true;
  late final curve = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOutBack,
  );

  void initAnimations(BuildContext context) {
    // Positions
    blueCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: 
      context.isIOS?
      const Offset(1.2, -0.65):const Offset(1.2, 0.65),
    ).animate(curve);

    redCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 3),
    ).animate(curve);
    yellowCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.85, -0.9),
    ).animate(curve);

    // Circles Size
    yellowCircleSize = Tween<double>(
      begin: 78.358,
      end: 116.305,
    ).animate(curve);

    // Circles Rotate
    yellowCircleRotate = Tween<double>(
      begin: 0,
      end: -0.7,
    ).animate(curve);

    // Opacity Opacity
    yellowCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.2,
    ).animate(curve);

    titleProductOpacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    textChooseSizeOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    redCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.5,
    ).animate(curve);

    backgroundColorAnimation = ColorTween(
      begin: AppColors.productDetailsBackground,
      end: AppColors.white,
    ).animate(animationController);
  }

  void startInitAnimation() {
    animationController.forward();
 Future.delayed(const Duration(milliseconds: 200), () {
      showChooseSizeViewFunc();
    });
  }

  void reverseInitAnimation() {
    animationController.reverse();

    Future.delayed(const Duration(milliseconds: 600), () {
      showChooseSizeViewFunc();
    });
  }

  void showChooseSizeViewFunc() {
    isProductDetailsVisible = !isProductDetailsVisible;
    emit(ProductDetailsVisible());
  }
}
