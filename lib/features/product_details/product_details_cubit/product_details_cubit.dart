import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/utils/custom_curves.dart';
import '../data/product_model.dart';

part 'product_details_state.dart';

enum ProductDetailsSizeEnum { small, medium, large }

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  static ProductDetailsCubit get(BuildContext context) => BlocProvider.of(context);

  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductModel selectedProduct = ProductModel.empty();
  ProductDetailsSizeEnum? productDetailsSizeEnum = ProductDetailsSizeEnum.medium;
  double sizeImageChooseSizeProduct = 224.53;

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
//
  late Animation<Offset> imageSlideTransition;

  bool isProductDetailsVisible = true;

  late final curve = CurvedAnimation(
    parent: animationController,
    curve: easeInOutBackSlow,
    reverseCurve: easeInOutBackSlow,
  );

  void initAnimations() {
    // Positions
    blueCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.2, -0.65),
    ).animate(curve);

    redCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2),
    ).animate(curve);
    yellowCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.85, -0.8),
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

    // Circles Opacity
    yellowCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.15,
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
      end: 0.2,
    ).animate(curve);

    backgroundColorAnimation = ColorTween(
      begin: AppColors.productDetailsBackground,
      end: AppColors.white,
    ).animate(animationController);

    imageSlideTransition = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(curve);
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
      productDetailsSizeEnum = ProductDetailsSizeEnum.medium;
      sizeImageChooseSizeProduct = 224.53;
    });
  }

  void selectedProductFunc(ProductModel product) {
    selectedProduct = product;
    emit(ProductSelected());
  }

  void showChooseSizeViewFunc() {
    isProductDetailsVisible = !isProductDetailsVisible;
    emit(ProductDetailsVisible());
  }

  void changeProductSize(ProductDetailsSizeEnum size) {
    productDetailsSizeEnum = size;
    changeSizeAndPositionImageChooseSize(size);
    emit(ProductDetailsSizeChanged());
  }

  void changeSizeAndPositionImageChooseSize(ProductDetailsSizeEnum size) {
    switch (size) {
      case ProductDetailsSizeEnum.medium:
        sizeImageChooseSizeProduct = 224.53;
        break;
      case ProductDetailsSizeEnum.small:
        sizeImageChooseSizeProduct = 161.05;

        break;
      case ProductDetailsSizeEnum.large:
        sizeImageChooseSizeProduct = 300;

        break;
      default:
        sizeImageChooseSizeProduct = 224.53;
    }
  }

  int get indexProduct => productDetailsSizeEnum?.index ?? 1;
  SizeWithPriceProductModel get detailsProduct {
    if (selectedProduct.price.isNotEmpty) {
      return selectedProduct.sizeWithPrice[indexProduct];
    }
    return SizeWithPriceProductModel.empty();
  }
}
