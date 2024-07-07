import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late Animation<double> textOpacity;
  late Animation<double> redCircleOpacity;

  // Circles Size
  late Animation<double> yellowCircleSize;

  // Circles Rotate
  late Animation<double> yellowCircleRotate;

  bool isProductDetailsVisible = true;
  late final curve = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOutBack,
  );

  void initAnimations() {
    // Positions
    blueCirclePosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.2, -0.65),
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
    textOpacity = Tween<double>(
      begin: 1,
      end: 0.2,
    ).animate(curve);
    redCircleOpacity = Tween<double>(
      begin: 1,
      end: 0.5,
    ).animate(curve);
  }

  void startInitAnimation() {
    showChooseSizeViewFunc();

    animationController.forward();
  }

  void reverseInitAnimation() {
    showChooseSizeViewFunc();

    animationController.reverse();
  }

  void showChooseSizeViewFunc() {
    isProductDetailsVisible = !isProductDetailsVisible;
    emit(ProductDetailsVisible());
  }
}
