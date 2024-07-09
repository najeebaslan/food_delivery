import 'package:flutter/material.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/styles/app_colors.dart';

class ProductModel {
  final String title;
  final String price;
  final Color color;
  final String imageUrl;

  final List<SizeWithPriceProduct> sizeWithPrice;
  ProductModel({
    required this.title,
    required this.price,
    required this.color,
    required this.sizeWithPrice,
    required this.imageUrl,
  });

  factory ProductModel.empty() {
    return ProductModel(
      title: '',
      price: '',
      color: AppColors.background,
      imageUrl: '',
      sizeWithPrice: [],
    );
  }

  static List<ProductModel> products = [
    ProductModel(
      color: AppColors.yellow,
      title: '',
      price: '\$7.50',
      sizeWithPrice: [
        SizeWithPriceProduct(
          size: 'S',
          price: '\$7.50',
          calories: '200 calories',
          weight: '200 gr',
        ),
        SizeWithPriceProduct(
          size: 'M',
          price: '\$10.50',
          calories: '300 calories',
          weight: '300 gr',
        ),
        SizeWithPriceProduct(
          size: 'L',
          price: '\$15.50',
          calories: '400 calories',
          weight: '400 gr',
        ),
      ],
      imageUrl: ImagesConstants.homeBoxDonut,
    ),
    ProductModel(
      title: 'Spudnut',
      price: '\$17.30',
      color: AppColors.green,
      imageUrl: ImagesConstants.crossDonut,
      sizeWithPrice: [
        SizeWithPriceProduct(
          size: 'S',
          price: '\$7.30',
          calories: '479 calories',
          weight: '400 gr',
        ),
        SizeWithPriceProduct(
          size: 'M',
          price: '\$17.30',
          calories: '879 calories',
          weight: '700 gr',
        ),
        SizeWithPriceProduct(
          size: 'L',
          price: '\$27.30',
          calories: '1379 calories',
          weight: '1400 gr',
        ),
      ],
    ),
    ProductModel(
      title: 'Ube',
      price: '\$3.50',
      color: AppColors.red,
      imageUrl: ImagesConstants.tridonut,
      sizeWithPrice: [
        SizeWithPriceProduct(
          size: 'S',
          price: '\$3.50',
          calories: '100 calories',
          weight: '100 gr',
        ),
        SizeWithPriceProduct(
          size: 'M',
          price: '\$5.50',
          calories: '200 calories',
          weight: '200 gr',
        ),
        SizeWithPriceProduct(
          size: 'L',
          price: '\$7.50',
          calories: '300 calories',
          weight: '300 gr',
        ),
      ],
    ),
    ProductModel(
      title: 'Vanilla',
      price: '\$20.50',
      color: AppColors.yellow,
      imageUrl: ImagesConstants.tridonut,
      sizeWithPrice: [
        SizeWithPriceProduct(
          size: 'S',
          price: '\$20.50',
          calories: '200 calories',
          weight: '200 gr',
        ),
        SizeWithPriceProduct(
          size: 'M',
          price: '\$30.50',
          calories: '300 calories',
          weight: '300 gr',
        ),
        SizeWithPriceProduct(
          size: 'L',
          price: '\$40.50',
          calories: '400 calories',
          weight: '400 gr',
        ),
      ],
    ),
  ];
}

class SizeWithPriceProduct {
  final String size;
  final String price;
  final String calories;
  final String weight;
  SizeWithPriceProduct({
    required this.size,
    required this.price,
    required this.calories,
    required this.weight,
  });

  factory SizeWithPriceProduct.empty() {
    return SizeWithPriceProduct(
      calories: '',
      price: '',
      size: '',
      weight: '',
    );
  }
}
