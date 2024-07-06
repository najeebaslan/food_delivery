import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/features/product_details/product_details_cubit/product_details_cubit.dart';
import 'package:food_delivery/features/product_details/widgets/base_circles/product_details_card.dart';
import 'package:gap/gap.dart';

import '../../data/product_model.dart';

class ProductDetailsListView extends StatelessWidget {
  const ProductDetailsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(context.isIOS ? 190.h : 150.h),
            ...List.generate(ProductModel.products.length, (index) {
              return GestureDetector(
                onTap: () => ProductDetailsCubit.get(context).showChooseSizeViewFunc(),
                child: ProductDetailsCard(
                  product: ProductModel.products[index],
                  index: index,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
