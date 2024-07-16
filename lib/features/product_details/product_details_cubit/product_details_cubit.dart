import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/utils/custom_curves.dart';
import '../data/product_model.dart';

part 'product_details_state.dart';

enum ProductDetailsSizeEnum { small, medium, large }

enum AnimationChooseSizeStatus { started, reverse, init }

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  static ProductDetailsCubit get(BuildContext context) => BlocProvider.of(context);

  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductModel selectedProduct = ProductModel.empty();
  ProductDetailsSizeEnum? productDetailsSizeEnum = ProductDetailsSizeEnum.medium;
  double sizeImageChooseSizeProduct = 220;
  AnimationChooseSizeStatus animationChooseSizeStatus = AnimationChooseSizeStatus.init;

  late AnimationController animationController;
  late Animation<double> titleProductOpacity;
  late Animation<double> textChooseSizeOpacity;
  late Animation backgroundColorAnimation;
  late Animation<Offset> imageSlideTransition;

  bool isProductDetailsVisible = true;

  late final curve = CurvedAnimation(
    parent: animationController,
    curve: easeInOutBackSlow30,
    reverseCurve: easeInOutBackSlow30,
  );

  void initAnimations() {
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
    animationChooseSizeStatus = AnimationChooseSizeStatus.started;
    emit(ChangeStateAnimation());

    animationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      showChooseSizeViewFunc();
    });
  }

  void reverseInitAnimation() {
    animationChooseSizeStatus = AnimationChooseSizeStatus.reverse;
    emit(ChangeStateAnimation());

    animationController.reverse();

    Future.delayed(const Duration(milliseconds: 600), () {
      showChooseSizeViewFunc();

      productDetailsSizeEnum = ProductDetailsSizeEnum.medium;
      sizeImageChooseSizeProduct = 220;
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

  void changeProductSize(ProductDetailsSizeEnum newSize) {
    if (newSize.index == productDetailsSizeEnum!.index) return;
    productDetailsSizeEnum = newSize;

    changeSizeAndPositionImageChooseSize(newSize);

    emit(ProductDetailsSizeChanged());
  }

  void changeSizeAndPositionImageChooseSize(ProductDetailsSizeEnum size) {
    switch (size) {
      case ProductDetailsSizeEnum.medium:
        sizeImageChooseSizeProduct = 220;
        break;
      case ProductDetailsSizeEnum.small:
        sizeImageChooseSizeProduct = 161.05;
        break;
      case ProductDetailsSizeEnum.large:
        sizeImageChooseSizeProduct = 290;
        break;
      default:
        sizeImageChooseSizeProduct = 220;
    }
  }

  int get indexProduct => productDetailsSizeEnum?.index ?? 1;

  SizeWithPriceProductModel get detailsProduct {
    return selectedProduct.price.isNotEmpty
        ? selectedProduct.sizeWithPrice[indexProduct]
        : SizeWithPriceProductModel.empty();
  }

  bool get isStartChooseSizeAnimation =>
      animationChooseSizeStatus == AnimationChooseSizeStatus.started;

  bool get isReversChooseSizeAnimation =>
      animationChooseSizeStatus == AnimationChooseSizeStatus.reverse;
}
