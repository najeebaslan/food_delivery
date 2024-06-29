import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/styles/app_colors.dart';
import '../home/views/widgets/app_bar/hero_red_circle_app_bar_home_view.dart';
import 'widgets/hero_blue_circle_product.dart';
import 'widgets/product_details_list_items.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: AppColors.productDetailsBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: 24.w,
            left: 24.w,
          ),
          child: SizedBox(
            height: 896.h,
            width: 414.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 150.h,
                  left: -70.w,
                  child: _blueCircle(),
                ),
                Positioned(
                  width: 235.w,
                  height: 37.h,
                  top: 200.h,
                  left: 0.w,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 235.w,
                      maxHeight: 37.h,
                    ),
                    child: Text(
                      'Donuts',
                      style: AppTextStyles.font30Black700W,
                    ),
                  ),
                ),
                Positioned(
                  top: 150.h,
                  height: 78.358.h,
                  width: 78.358.w,
                  right: 53.w,
                  child: _yellowCircle(),
                ),
                Positioned(
                  top: 180.h,
                  height: 48.13.h,
                  width: 48.13.w,
                  right: 30.w,
                  child: _redCircle(),
                ),
                const ProductDetailsListItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Hero _redCircle() {
    return Hero(
      createRectTween: (begin, end) {
        return CustomRectTween(
          begin: begin!,
          end: end!,
        );
      },
      tag: 'drinkTag',
      child: Transform.rotate(
        angle: 2.1,
        child: SvgPicture.asset(
          ImagesConstants.ellipseRed,
          height: 48.13.h,
          width: 48.13.w,
        ),
      ),
    );
  }

  Hero _yellowCircle() {
    return Hero(
      tag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
      createRectTween: (begin, end) {
        return CustomRectTween(
          begin: begin!,
          end: end!,
        );
      },
      child: SvgPicture.asset(
        ImagesConstants.onboardingCircleBoldYellow,
        height: 78.358.h,
        width: 78.358.w,
      ),
    );
  }

  Widget _blueCircle() {
    return HeroBlueCircleProduct(
      parameters: HeroRedCircleParameters(
        height: 195.023.h,
        width: 195.023.w,
        animatedBuilderChildAngle: (animationValue) {
          return animationValue > 7 ? 5.3 : 3;
        },
      ),
    );
  }
}
