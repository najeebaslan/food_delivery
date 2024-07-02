import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:gap/gap.dart';

import '../../../core/styles/app_colors.dart';
import '../data/product_model.dart';
import 'title_and_subtitle_product.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({
    super.key,
    required this.product,
    required this.index,
  });
  final ProductModel product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: _isOdd(index) ? Alignment.centerRight : Alignment.centerLeft,
          width: 362.w,
          height: 154.h,
          margin: EdgeInsets.only(
            bottom: 24.h,
          ),
          padding: EdgeInsets.only(
            left: 15.w,
            bottom: 11.h,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: product.color,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            shadows: [
              BoxShadow(
                color: const Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 10.h),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: _isOdd(index) ? 10.w : 0,
                  left: _isOdd(index) ? 0 : 0.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      _isOdd(index) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    TitleAndSubtitleProduct(
                      isOdd: _isOdd(index),
                      index: index,
                      title: product.title,
                      color: product.color,
                    ),
                    Gap(24.h),
                    Flexible(
                      flex: 0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 28.h,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: !_isOdd(index) ? 15.w : 0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: _isOdd(index)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.price,
                                style: AppTextStyles.font20White700W.copyWith(
                                  color: AppColors.black,
                                  height: 0,
                                ),
                              ),
                              Gap(15.w),
                              if (index != 1 && !_isOdd(index)) const Spacer(),
                              _addIconButton(context)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: _isOdd(index) ? -10.h : -19.h,
          width: 130.w,
          height: 130.w,
          right: _isOdd(index) ? null : -12.w,
          left: _isOdd(index) ? 0.w : null,
          child: _buildImageProduct(),
        ),
      ],
    );
  }

  SizedBox _buildImageProduct() {
    return SizedBox(
      width: 130.w,
      height: 130.w,
      child: FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.center,
        child: Image.asset(
          product.imageUrl,
          width: 130.w,
          height: 130.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container _addIconButton(BuildContext context) {
    return Container(
      width: 28.w,
      height: 24.h,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF4DB066),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            40.r,
          ),
        ),
      ),
      child: Icon(
        PlatformIcons(context).add,
        color: AppColors.white,
        size: 15.sp,
      ),
    );
  }

  bool _isOdd(int index) => index % 2 != 0;
}
