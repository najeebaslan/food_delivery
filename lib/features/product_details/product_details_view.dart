import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';
import 'package:food_delivery/features/home/blocs/home_animation_cubit/home_animation_cubit.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/hero_tags_constants.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../../core/widget/adaptive_widget/adaptive_app_bar.dart';
import '../home/views/widgets/header_text_field.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<HomeAnimationCubit>()
          .reverseProductDetailsAnimationAndBackToHomeView(),
      child: Container(
        alignment: AlignmentDirectional.centerEnd,
        height: context.height,
        width: context.width,
        color: AppColors.productDetailsBackground,
        child: SizedBox(
          height: 896.h,
          width: 414.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // !context.read<HomeAnimationCubit>().hideRedCircleFat
              //     ? Positioned(
              //         top: context.isIOS ? 150.h : 10.h,
              //         left: -70.w,
              //         child: _blueCircle(),
              //       )
              //     : const SizedBox.shrink(),
              Positioned(
                width: 235.w,
                height: 37.h,
                top: context.isIOS ? 200.h : 60.h,
                left: 25.w,
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
              // Positioned(
              //   top: context.isIOS ? 120.h : 80.h,
              //   height: 48.13.h,
              //   width: 48.13.w,
              //   right: 30.w,
              //   child: _redCircle(),
              // ),
              // Positioned(
              //   top: context.isIOS ? 80.h : 40.h,
              //   height: 78.358.h,
              //   width: 78.358.w,
              //   right: 53.w,
              //   child: _yellowCircle(),
              // ),
              // const Center(
              //   child: ProductDetailsListView(),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Transform _redCircle() {
    return Transform.rotate(
      angle: 2,
      child: SvgPicture.asset(
        ImagesConstants.ellipseRed,
        height: 48.13.h,
        width: 48.13.w,
      ),
    );
  }
  // Widget _redCircle() {
  //   return HeroSmallRedCircleAppBarHomeView(
  //     height: 48.13.h,
  //     width: 48.13.w,
  //     angle: 2,
  //   );
  // }

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

  Widget _blueCircle({Color? color}) {
    return Transform.rotate(
      angle: 3,
      child: Opacity(
        opacity: 0.10,
        child: SvgPicture.asset(
          ImagesConstants.ellipseRed,
          height: 195.023.h,
          width: 195.023.w,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                )
              : null,
        ),
      ),
    );
    // HeroBlueCircleProduct(
    //   parameters: HeroRedCircleParameters(
    //     height: 195.023.h,
    //     width: 195.023.w,
    //     animatedBuilderChildAngle: (animationValue) {
    //       return animationValue > 7 ? 5.3 : 3;
    //     },
    //   ),
    // );
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
