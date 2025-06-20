import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:gap/gap.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/product_model.dart';
import 'title_and_subtitle_product.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({super.key, required this.product, required this.index});
  final ProductModel product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: index.isOdd ? Alignment.centerRight : Alignment.centerLeft,
          width: 362.w,
          height: 154.h,
          margin: EdgeInsets.only(bottom: 24.h),
          padding: EdgeInsets.only(left: 15.w, bottom: 11.h),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: product.color),
              borderRadius: BorderRadius.circular(20.r),
            ),
            shadows: [
              BoxShadow(
                color: const Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 10.h),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: index.isOdd ? 10.w : 0,
                  left: index.isOdd ? 0 : 0.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      index.isOdd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    // Gap(24.h),
                    TitleAndSubtitleProduct(
                      isOdd: index.isOdd,
                      index: index,
                      title: product.title,
                      color: product.color,
                    ),
                    Flexible(child: Gap(24.h)),
                    Flexible(
                      flex: 0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 28.h),
                        child: Padding(
                          padding: EdgeInsets.only(right: index.isEven ? 15.w : 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                index.isOdd
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
                              if (index != 1 && index.isEven) const Spacer(),
                              _addIconButton(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: _getTopOffset(),
          width: _getWidthHeight().w,
          height: _getWidthHeight().h,
          right: _getRightOffset(),
          left: index.isOdd ? 0.w : null,
          child: _buildImageProduct(index > 1 ? 110 : 130),
        ),
      ],
    );
  }

  double? _getRightOffset() {
    if (index.isEven) return index > 1 ? 0 : -12.w;
    return null;
  }

  double _getWidthHeight() => index > 1 ? 110 : 130;

  double _getTopOffset() {
    if (index.isOdd) {
      return -10.h;
    } else if (index > 1) {
      return -10.h;
    } else {
      return -19.h;
    }
  }

  Widget _buildImageProduct(double size) {
    return Transform.translate(
      offset: index == 3 ? Offset(8.w, -7.h) : Offset.zero,
      child: Transform.rotate(
        angle: index > 1 ? 0.2 : 0,
        child: Image.asset(product.imageUrl, width: size.w, height: size.h),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.r)),
      ),
      child: PlatformIconButton(
        padding: EdgeInsets.zero,
        icon: Icon(PlatformIcons(context).add, color: AppColors.white, size: 15.sp),
      ),
    );
  }
}
