import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/assets_constants.dart';
import 'widgets/app_bar_home_view.dart';
import 'widgets/header_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: AppColors.homeBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: 24.w,
            left: 24.w,
            top: 30.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarHomeView(),
              Gap(14.h),
              HeaderHomeView(),
              Gap(60.h),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 37.h,
                  maxWidth: 235.w,
                ),
                child: Text(
                  'Categories',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFFFABB2D),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Gap(30.h),
              RowCategoriesWithAnimation(),
            ],
          ),
        ),
      ),
    );
  }
}

class RowCategoriesWithAnimation extends StatelessWidget {
  const RowCategoriesWithAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
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
        Gap(10.w),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 83.h,
              width: 130.w,
              decoration: ShapeDecoration(
                color: AppColors.nearRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.r,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -60.h,
              // left: 0,
              child: Image.asset(
                ImagesConstants.homeBoxDonut,
                width: 121.w,
                height: 121.h,
              ),
            ),
            Positioned(
              bottom: 6.5.h,
              child: Text(
                'Donut',
                style: AppTextStyles.font30Whit300W.copyWith(
                  height: 0,
                ),
              ),
            )
          ],
        ),
        Gap(10.w),
      ],
    );
  }

  Widget _buildCategoryItem(String title, bool isSelected) {
    return Container(
      height: 37.h,
      width: 80.w,
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.yellow : Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.red : AppColors.black,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
    );
  }
}
