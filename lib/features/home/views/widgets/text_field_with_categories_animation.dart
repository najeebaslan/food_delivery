import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import 'categories_items.dart';
import 'header_text_field.dart';

class TextFieldWithCategoriesAnimation extends StatefulWidget {
  const TextFieldWithCategoriesAnimation({super.key});

  @override
  State<TextFieldWithCategoriesAnimation> createState() =>
      _TextFieldWithCategoriesAnimationState();
}

class _TextFieldWithCategoriesAnimationState
    extends State<TextFieldWithCategoriesAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> transformCardAll;
  late Animation<double> transformBurger;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    /// Scale all this on animation started
    scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(curve);

    /// Transform card burger when animation is started
    transformBurger = Tween<double>(
      begin: 0,
      end: -20.w,
    ).animate(curve);

    /// Transform card all when animation is started
    transformCardAll = Tween<double>(
      begin: 70,
      end: -3.w,
    ).animate(curve);

    /// Sild all this class form down to up
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.9),
      end: const Offset(0, 0.01),
    ).animate(curve);
    animationController.forward();
  }

  late final curve = CurvedAnimation(
    curve: Curves.easeInOut,
    parent: animationController,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SlideTransition(
          position: slideAnimation,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Column(
              children: [
                const HeaderTextField(),
                Gap(50.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 37.h,
                      maxWidth: 235.w,
                    ),
                    child: PlatformText(
                      'Categories',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.font20White700W.copyWith(
                        color: AppColors.yellow,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Gap(30.h),
                CategoriesItems(
                  transformCardAll: transformCardAll,
                  transformBurger: transformBurger,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
