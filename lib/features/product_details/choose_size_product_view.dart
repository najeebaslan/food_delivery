import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/features/product_details/product_details_cubit/product_details_cubit.dart';

class ChooseSizeProductView extends StatelessWidget {
  const ChooseSizeProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ProductDetailsCubit.get(context).animationController,
      builder: (context, child) {
        return Column(
          children: [
            
          ],
        );
      },
    );
  }
}
