import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/hero_tags_constants.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../../core/widget/adaptive_widget/adaptive_app_bar.dart';
import '../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import '../home/views/widgets/app_bar/app_bar_home_view.dart';
import '../home/views/widgets/app_bar/hero_red_circle_app_bar_home_view.dart';
import '../home/views/widgets/app_bar/hero_small_red_circle_app_bar_home_view.dart';
import '../home/views/widgets/header_text_field.dart';
import 'widgets/hero_blue_circle_product.dart';
import 'widgets/product_details_list_view.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: AppColors.productDetailsBackground,
      appBar: _buildAppBar(context),
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
                top: context.isIOS ? 50.h : 10.h,
                left: -70.w,
                child: _blueCircle(),
              ),
              Positioned(
                width: 235.w,
                height: 37.h,
                top: context.isIOS ? 100.h : 60.h,
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
                top: context.isIOS ? 120.h : 80.h,
                height: 48.13.h,
                width: 48.13.w,
                right: 30.w,
                child: _redCircle(),
              ),
              Positioned(
                top: context.isIOS ? 80.h : 40.h,
                height: 78.358.h,
                width: 78.358.w,
                right: 53.w,
                child: _yellowCircle(),
              ),
              const Center(
                child: ProductDetailsListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _redCircle() {
    return HeroSmallRedCircleAppBarHomeView(
      height: 48.13.h,
      width: 48.13.w,
      angle: 2,
    );
  }

  Widget _yellowCircle() {
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

  AdaptiveAppBar _buildAppBar(BuildContext context) {
    return AdaptiveAppBar(
      size: Size.fromHeight(context.isIOS ? 65.h : 115.h),
      customAppBar: Container(
        padding: EdgeInsets.only(
          right: 24.w,
          left: 24.w,
        ),
        color: AppColors.productDetailsBackground,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // const AppBarHomeView(
              //   showIconMenuWithTitleOnly: true,
              // ),
              Padding(
                padding: EdgeInsets.only(right: 15.w, bottom: 8.h),
                child: const HeaderTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
