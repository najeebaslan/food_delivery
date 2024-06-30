import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:gap/gap.dart';

import '../../../core/widget/adaptive_widget/adaptive_app_bar.dart';
import '../../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import 'widgets/app_bar/app_bar_home_view.dart';
import 'widgets/categories_animations.dart';
import 'widgets/header_text_field.dart';
import 'widgets/popular_list_items.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.redCircleTag});
  final String redCircleTag;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: const Offset(0, 0.01),
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: animationController,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: animationController,
      ),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: AdaptiveAppBar(
        size: Size.fromHeight(context.isIOS ? 65.h : 115.h),
        customAppBar: Container(
          padding: EdgeInsets.only(
            right: 24.w,
            left: 24.w,
            // top: 64.h,
          ),
          color: AppColors.homeBackground,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                AppBarHomeView(
                  redCircleTag: widget.redCircleTag,
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: slideAnimation,
                      child: Transform.scale(
                        scale: scaleAnimation.value,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: const HeaderTextField(),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 24.w, left: 24.w),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(10.h),
              Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: const CategoriesAnimations(),
              ),
              const PopularListItems(),
            ],
          ),
        ),
      ),
    );
  }
}
