import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/widget/base_animations/base_fade_animated_switcher.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../cubit/product_details_cubit.dart';
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
            return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              buildWhen:
                  (previous, current) =>
                      current is ProductSelected || current is ProductDetailsSizeChanged,
              builder: (context, state) {
                final productCubit = BlocProvider.of<ProductDetailsCubit>(context);
                bool isSmallDeviceX = context.height < 650.0;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, isSmallDeviceX ? -120.h : -100.h),
                      child: SlideTransition(
                        position: productCubit.imageSlideTransition,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: NumConstants.duration900),
                          curve: Curves.easeInOutBack,
                          width:
                              isSmallDeviceX
                                  ? (productCubit.sizeImageChooseSizeProduct.w * 0.7)
                                  : productCubit.sizeImageChooseSizeProduct.w,
                          height: productCubit.sizeImageChooseSizeProduct.h,
                          child: Image.asset(
                            key: ValueKey(productCubit.indexProduct),
                            ImagesConstants.tridonut,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(isSmallDeviceX ? constraints.maxHeight * 0.01 : 65.h),
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
                        Flexible(child: Gap(constraints.maxHeight / 2.4)),
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
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}