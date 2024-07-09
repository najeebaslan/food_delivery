import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/features/product_details/product_details_cubit/product_details_cubit.dart';
import 'package:gap/gap.dart';

import '../../../../core/widget/base_animations/base_fade_animated_switcher.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import 'body_choose_size_product_view.dart';

class ChooseSizeProductView extends StatelessWidget {
  const ChooseSizeProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ProductDetailsCubit.get(context).animationController,
      builder: (context, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            buildWhen: (previous, current) =>
                current is ProductSelected || current is ProductDetailsSizeChanged,
            builder: (context, state) {
              final productCubit = BlocProvider.of<ProductDetailsCubit>(context);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(65.h),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: BaseFadeAnimatedSwitcher(
                      child: Text(
                        key: ValueKey(productCubit.detailsProduct.price),
                        productCubit.detailsProduct.price,
                        style: AppTextStyles.font40DeepBlue500W.copyWith(
                          height: 0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  Gap(45.h),
                  Center(
                    child: Image.asset(
                      ImagesConstants.tridonut,
                      width: 254.53.w,
                      height: 254.53.h,
                      alignment: Alignment.center,
                    ),
                  ),
                  const BodyChooseSizeProductView(),
                  Center(
                    child: CustomElevatedButton(
                      title: 'Next',
                      width: 322.w,
                      height: 66.h,
                      backgroundColor: AppColors.red,
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
