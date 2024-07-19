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
  List<ProductDetailsSizeEnum> historySizeList = [
    ProductDetailsSizeEnum.medium,
  ];
  AnimationChooseSizeStatus animationChooseSizeStatus = AnimationChooseSizeStatus.init;
  late (ProductDetailsSizeEnum, ProductDetailsSizeEnum) getOldAndCurrentSize =
      (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.medium);

  late AnimationController animationController;
  late Animation<double> titleProductOpacity;
  late Animation<double> textChooseSizeOpacity;
  late Animation<double> yellowCirclePositionRight;

  late Animation backgroundColorAnimation;
  late Animation<Offset> imageSlideTransition;

  bool isProductDetailsVisible = true;

  void initAnimations() {
    titleProductOpacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutBack,
      ),
    );
    textChooseSizeOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutBack,
      ),
    );
    yellowCirclePositionRight = Tween<double>(
      begin: 53,
      end: -40,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: easeInOutBackSlow50,
      ),
    );

    backgroundColorAnimation = ColorTween(
      begin: AppColors.productDetailsBackground,
      end: AppColors.white,
    ).animate(animationController);

    imageSlideTransition = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: easeInOutBackSlow30,
      ),
    );
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
      getOldAndCurrentSize =
          (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.medium);
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
    ProductDetailsSizeEnum firstOut = historySizeList.first;

    historySizeList.clear();
    historySizeList.addAll([
      productDetailsSizeEnum!,
      newSize,
      firstOut,
    ]);
    getOldAndCurrentSize = (productDetailsSizeEnum!, newSize);
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
        sizeImageChooseSizeProduct = 278;
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

  void changeGetOldAndCurrentSizeToMedium() {
    getOldAndCurrentSize = (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.medium);
  }

  bool get isChangeCircleFromSmallToLarge {
    return getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.large);
  }

  bool get isChangeCircleFromSmallToMedium {
    return getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.small, ProductDetailsSizeEnum.medium);
  }

  bool get isChangeCircleFromLargeToSmall {
    return getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.small);
  }

  bool get isChangeCircleFromLargeToMedium {
    return getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.large, ProductDetailsSizeEnum.medium);
  }

  bool get isChangeCircleFromMediumToSmall {
    return getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.small);
  }

  bool get isChangeCircleFromMediumToLarge {
    return getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.large);
  }

  bool get isChangeCircleFromMediumToMedium {
    return getOldAndCurrentSize ==
        (ProductDetailsSizeEnum.medium, ProductDetailsSizeEnum.medium);
  }

  @override
  Future<void> close() {
    animationController.dispose();
    return super.close();
  }
}
