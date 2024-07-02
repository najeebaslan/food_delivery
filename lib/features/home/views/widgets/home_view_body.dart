import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/features/home/views/widgets/categories_animations.dart';
import 'package:food_delivery/features/home/views/widgets/popular_list_items.dart';
import 'package:gap/gap.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            Gap(kToolbarHeight * (context.isIOS ? 2.5 : 3).h),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: const CategoriesAnimations(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: const PopularListItems(),
            ),
          ],
        ),
      ),
    );
  }
}