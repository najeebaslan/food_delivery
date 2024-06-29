import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/styles/app_colors.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({super.key, required this.index});
  final int index;
  static List<Color> borderColors = [
    AppColors.yellow,
    AppColors.green,
    AppColors.red,
    AppColors.yellow,
  ];
  static const List<String> imagesUrl = [
    ImagesConstants.homeBoxDonut,
    ImagesConstants.tridonut,
    ImagesConstants.tridonut,
    ImagesConstants.tridonut,
  ];
  static const List<String> titles = [
    '',
    'Spudnut',
    'Ube',
    'Vanilla',
  ];
  static const List<String> prices = [
    '\$7.50',
    '\$17.30',
    '\$3.50',
    '\$20.50',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isOdd(index) ? Alignment.centerRight : Alignment.centerLeft,
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
            color: borderColors[index],
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
      child: Padding(
        padding: EdgeInsets.only(
          right: isOdd(index) ? 10.w : 0,
          left: isOdd(index) ? 0 : 0.w,
        ),
        child: Column(
          crossAxisAlignment:
              isOdd(index) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                textDirection: isOdd(index) ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  _buildTitleAndSubtitleProduct(),
                  const Spacer(),
                  _buildImageProduct(),
                ],
              ),
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
                    right: 15.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isOdd(index)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 140.w,
                        height: 28.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              prices[index],
                              style: AppTextStyles.font20White700W.copyWith(
                                color: AppColors.black,
                                height: 0,
                              ),
                            ),
                            Gap(15.w),
                            if (!isOdd(index)) addIconButton(context) else const Spacer(),
                          ],
                        ),
                      ),
                      if (isOdd(index)) addIconButton(context)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildTitleAndSubtitleProduct() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isOdd(index) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          titles[index],
          textAlign: isOdd(index) ? TextAlign.left : TextAlign.right,
          style: AppTextStyles.font30Black400W.copyWith(
            height: 0,
          ),
        ),
        if (index != 0)
          Container(
            width: 80.w,
            height: 3.h,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: ShapeDecoration(
              color: borderColors[index],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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
          )
        else
          Gap(3.h),
        AutoSizeText(
          'Want a delicious meal, but no \ntime we will deliver it hot and yummy.',
          textAlign: isOdd(index) ? TextAlign.right : TextAlign.left,
          textDirection: TextDirection.ltr,
          style: AppTextStyles.font14Black400W.copyWith(
            height: 0,
          ),
        )
      ],
    );
  }

  Expanded _buildImageProduct() {
    return Expanded(
      flex: 10,
      child: SizedBox(
        width: 130.w,
        height: 130.w,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset(
            imagesUrl[index],
            width: 130.w,
            height: 130.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Container addIconButton(BuildContext context) {
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
      child: PlatformIconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          PlatformIcons(context).add,
          color: AppColors.white,
          size: 15.sp,
        ),
      ),
    );
  }

  bool isOdd(int index) {
    if (index == 0) return false;
    if (index == 1) return true;
    return index % 2 != 0;
  }
}
