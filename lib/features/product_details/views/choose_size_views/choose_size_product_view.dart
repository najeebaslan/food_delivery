import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/core/utils/custom_curves.dart';
import 'package:gap/gap.dart';

import '../../../../core/widget/base_animations/base_fade_animated_switcher.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../product_details_cubit/product_details_cubit.dart';
import 'body_choose_size_product_view.dart';

class ChooseSizeProductView extends StatelessWidget {
  const ChooseSizeProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ProductDetailsCubit.get(context).animationController,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                buildWhen: (previous, current) =>
                    current is ProductSelected || current is ProductDetailsSizeChanged,
                builder: (context, state) {
                  final productCubit = BlocProvider.of<ProductDetailsCubit>(context);

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(65.h),
                          Padding(
                            padding: EdgeInsets.only(left: 40.w),
                            child: BaseFadeAnimatedSwitcher(
                              durationMs: NumConstants.duration900,
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
                          Gap(constraints.maxHeight / 2.5), // make ui responsive
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
                          Gap(30.h),
                        ],
                      ),
                      Positioned(
                        top: constraints.maxHeight / 5,
                        child: SlideTransition(
                          position: productCubit.imageSlideTransition,
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: NumConstants.duration900-50,
                            ),
                            curve: easeInOutBackWithFastOutBack,
                            width: productCubit.sizeImageChooseSizeProduct.w,
                            height: productCubit.sizeImageChooseSizeProduct.h,
                            child: Image.asset(
                              key: ValueKey(productCubit.indexProduct),
                              ImagesConstants.tridonut,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
