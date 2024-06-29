import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/home/views/widgets/header_text_field.dart';
import 'package:food_delivery/features/product_details/widgets/product_details_card.dart';
import 'package:gap/gap.dart';

import '../../home/views/widgets/app_bar/app_bar_home_view.dart';

class ProductDetailsListItems extends StatelessWidget {
  const ProductDetailsListItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppBarHomeView(
            redCircleTag: 'redCircleTag',
            showIconMenuWithTitleOnly: true,
          ),
          Gap(21.h),
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: const HeaderTextField(
              startAnimationHero: true,
            ),
          ),
          Gap(157.h),
          ...List.generate(4, (index) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: ProductDetailsCard(index: index),
            );
          })
        ],
      ),
    );
  }
}
