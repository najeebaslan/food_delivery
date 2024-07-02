import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/features/product_details/widgets/product_details_card.dart';
import 'package:gap/gap.dart';

import '../data/product_model.dart';

class ProductDetailsListView extends StatelessWidget {
  const ProductDetailsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(context.isIOS ? 275.h : 150.h),
            ...List.generate(
              ProductModel.products.length,
              (index) {
                return ProductDetailsCard(
                  product: ProductModel.products[index],
                  index: index,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
