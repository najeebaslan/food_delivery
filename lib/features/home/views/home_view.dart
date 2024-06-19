import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:gap/gap.dart';

import 'widgets/app_bar_home_view.dart';
import 'widgets/categories_items.dart';
import 'widgets/header_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: AppColors.homeBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 24.w, left: 24.w, top: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppBarHomeView(),
                // Gap(14.h),
                const HeaderHomeView(),
                Gap(50.h),
                _buildTitle(title: 'Categories'),
                Gap(30.h),
                const CategoriesItems(),
                Gap(47.h),
                _buildTitle(
                  title: 'Popular',
                  color: AppColors.black,
                ),
                Gap(30.h),

                const PopularListItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _buildTitle({required String title, Color? color}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 37.h,
          maxWidth: 235.w,
        ),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: AppTextStyles.font20White700W.copyWith(
            color: color ?? AppColors.yellow,
            height: 0,
          ),
        ),
      ),
    );
  }
}

class PopularListItems extends StatelessWidget {
  const PopularListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362.w,
      height: 154.h,
      decoration: ShapeDecoration(
        color: Colors.white,
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
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 199.w,
            height: 199.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(ImagesConstants.hotDogIsometric),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x26000000).withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(-4, -1),
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          Image.asset(
            ImagesConstants.hotDogIsometric,
          ),
          const Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
