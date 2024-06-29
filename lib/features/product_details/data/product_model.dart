import 'package:flutter/material.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/styles/app_colors.dart';

class ProductModel {
  final String title;
  final String price;
  final Color color;
  final String imageUrl;
  ProductModel({
    required this.title,
    required this.price,
    required this.color,
    required this.imageUrl,
  });

  static List<ProductModel> products = [
    ProductModel(
      color: AppColors.yellow,
      title: '',
      price: '\$7.50',
      imageUrl: ImagesConstants.homeBoxDonut,
    ),
    ProductModel(
      title: 'Spudnut',
      price: '\$17.30',
      color: AppColors.green,
      imageUrl: ImagesConstants.crossDonut,
    ),
    ProductModel(
      title: 'Ube',
      price: '\$3.50',
      color: AppColors.red,
      imageUrl: ImagesConstants.tridonut,
    ),
    ProductModel(
      title: 'Vanilla',
      price: '\$20.50',
      color: AppColors.yellow,
      imageUrl: ImagesConstants.tridonut,
    ),
  ];
}
