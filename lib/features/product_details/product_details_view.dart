import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/hero_tags_constants.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/styles/app_colors.dart';
import '../../core/widget/adaptive_widget/adaptive_app_bar.dart';
import '../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import '../home/views/widgets/app_bar/app_bar_home_view.dart';
import '../home/views/widgets/app_bar/hero_red_circle_app_bar_home_view.dart';
import '../home/views/widgets/header_text_field.dart';
import 'widgets/hero_blue_circle_product.dart';
import 'widgets/product_details_list_items.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: AppColors.productDetailsBackground,
      appBar: AdaptiveAppBar(
        customAppBar: _buildAppBar(),
      ),
      body: Padding(
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
                top: 50.h,
                left: -70.w,
                child: _blueCircle(),
              ),
              Positioned(
                width: 235.w,
                height: 37.h,
                top: 100.h,
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
                top: 80.h,
                height: 78.358.h,
                width: 78.358.w,
                right: 53.w,
                child: _yellowCircle(),
              ),
              Positioned(
                top: 120.h,
                height: 48.13.h,
                width: 48.13.w,
                right: 30.w,
                child: _redCircle(),
              ),
              const Center(child: ProductDetailsListItems()),
            ],
          ),
        ),
      ),
    );
  }

  Hero _redCircle() {
    return Hero(
      tag: 'drinkTag',
      child: Transform.rotate(
        angle: 2.3,
        child: SvgPicture.asset(
          ImagesConstants.ellipseRed,
          height: 48.13.h,
          width: 48.13.w,
        ),
      ),
      createRectTween: (begin, end) {
        return CustomRectTween(
          begin: begin!,
          end: end!,
        );
      },
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

  AdaptiveAppBar _buildAppBar() {
    return AdaptiveAppBar(
      size: Size.fromHeight(65.h),
      customAppBar: Container(
        padding: EdgeInsets.only(
          right: 24.w,
          left: 24.w,
          top: 64.h,
        ),
        color: AppColors.productDetailsBackground,
        child: Column(
          children: [
            const AppBarHomeView(
              showIconMenuWithTitleOnly: true,
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: const HeaderTextField(),
            ),
          ],
        ),
      ),
    );
  }
}
