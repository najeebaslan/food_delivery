import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/num_constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widget/base_animations/base_fade_animated_switcher.dart';
import '../../product_details_cubit/product_details_cubit.dart';

class BodyChooseSizeProductView extends StatelessWidget {
  const BodyChooseSizeProductView({super.key});
  static List<String> sizesType = ['Small  ', 'Medium', 'Large'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (previous, current) =>
          current is ProductSelected || current is ProductDetailsSizeChanged,
      builder: (context, state) {
        final sizeProduct = sizesType[context.read<ProductDetailsCubit>().indexProduct];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sizeProductTitle(context, sizeProduct),
            Gap(20.h),
            _circlesSize(context, sizeProduct[0]),
            Gap(28.h),
            Center(
              child: Container(
                width: 362.w,
                height: 98.h,
                padding: EdgeInsets.all(22.h),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xA04DB066),
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    OverflowBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Calories',
                          style: AppTextStyles.font14Black400W.copyWith(
                            height: 0,
                          ),
                        ),
                        Text(
                          'Weight',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.font14Black400W.copyWith(
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Gap(7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _titleWithAnimatedSwitcher(
                          context.read<ProductDetailsCubit>().detailsProduct.calories,
                        ),
                        _titleWithAnimatedSwitcher(
                          context.read<ProductDetailsCubit>().detailsProduct.weight,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(44.h),
          ],
        );
      },
    );
  }

  Padding _sizeProductTitle(BuildContext context, String sizeProduct) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: SizedBox(
        width: 196.w,
        height: 28.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Choose size -',
              textAlign: TextAlign.left,
              style: AppTextStyles.font20Black300W.copyWith(
                height: 0,
                fontStyle: FontStyle.italic,
              ),
            ),
            BaseFadeAnimatedSwitcher(
              child: PlatformText(
                key: ValueKey('${sizeProduct}subtitle'),
                sizeProduct,
                textAlign: TextAlign.left,
                style: AppTextStyles.font20Black300W.copyWith(
                  height: 0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleWithAnimatedSwitcher(String title) {
    return BaseFadeAnimatedSwitcher(
      stackAlignment: title.contains('gr') ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        textAlign: title.contains('gr') ? TextAlign.right : TextAlign.left,
        key: ValueKey(title),
        title,
        style: AppTextStyles.font20Black500W.copyWith(
          height: 0,
        ),
      ),
    );
  }

  SizedBox _circlesSize(BuildContext context, String sizeProduct) {
    return SizedBox(
      height: 40.71.h,
      child: Padding(
        padding: EdgeInsets.only(left: 21.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              3,
              (index) {
                final bool isSelected = sizeProduct == sizesType[index][0];
                return GestureDetector(
                  onTap: () => ProductDetailsCubit.get(context).changeProductSize(
                    ProductDetailsSizeEnum.values[index],
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: NumConstants.animationDuration,
                    ),
                    curve: Curves.easeInOutBack,
                    width: isSelected ? 44.w : 28.w,
                    height: isSelected ? 37.71 : 24.h,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: isSelected ? AppColors.green : AppColors.gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: PlatformText(
                      sizesType[index][0],
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14Black300W.copyWith(
                        height: 0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
