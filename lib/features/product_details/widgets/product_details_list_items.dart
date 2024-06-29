import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/product_details/widgets/product_details_card.dart';
import 'package:gap/gap.dart';

import '../data/product_model.dart';

class ProductDetailsListItems extends StatelessWidget {
  const ProductDetailsListItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(190.h),
          ...List.generate(ProductModel.products.length, (index) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: ProductDetailsCard(
                product: ProductModel.products[index],
                index: index,
              ),
            );
          })
        ],
      ),
    );
  }
}
