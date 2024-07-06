import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  static ProductDetailsCubit get(BuildContext context) => BlocProvider.of(context);

  ProductDetailsCubit() : super(ProductDetailsInitial());
  bool isProductDetailsVisible = true;
  void showChooseSizeViewFunc() {
    isProductDetailsVisible = !isProductDetailsVisible;
    emit(ProductDetailsVisible());
  }
}
