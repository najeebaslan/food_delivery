import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class CategoriesItems extends StatelessWidget {
  const CategoriesItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      verticalDirection: VerticalDirection.down,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 0,
          child: Container(
            height: 118.h,
            width: 81.w,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: AppColors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'All',
              style: AppTextStyles.font16Black400W.copyWith(
                height: 0,
              ),
            ),
          ),
        ),
        Gap(10.w),
        Flexible(
          flex: 0,
          child: _buildCard(
            imageUri: ImagesConstants.homeBoxDonut,
            isBurger: false,
          ),
        ),
        Gap(10.w),
        Flexible(
          flex: 1,
          child: _buildCard(
            imageUri: ImagesConstants.burgerIsometric,
            isBurger: true,
          ),
        ),
      ],
    );
  }

  Stack _buildCard({required String imageUri, required bool isBurger}) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 83.h,
          width: 130.w,
          decoration: ShapeDecoration(
            color: isBurger ? AppColors.green : AppColors.nearRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
          ),
        ),
        Positioned(
          top: isBurger ? -90.h : -60.h,
          child: isBurger
              ? Container(
                  width: 170.74.w,
                  height: 170.74.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageUri),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              : Image.asset(
                  imageUri,
                  width: isBurger ? 170.74.w : 121.w,
                  height: isBurger ? 170.74.h : 121.h,
                ),
        ),
        Positioned(
          bottom: 6.5.h,
          child: Text(
            isBurger ? 'Burger' : 'Donut',
            style: AppTextStyles.font30White300W.copyWith(
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}
