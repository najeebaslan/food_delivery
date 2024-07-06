
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/widget/adaptive_widget/adaptive_app_bar.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/num_constants.dart';
import '../../../core/styles/app_colors.dart';
import '../../home/views/widgets/header_text_field.dart';
import '../product_details_cubit/product_details_cubit.dart';
import 'app_bar_product_details.dart';

class AppBarAdapterProductDetailsAndChooseSize extends AdaptiveAppBar {
  const AppBarAdapterProductDetailsAndChooseSize({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return AdaptiveAppBar(
          size: Size.fromHeight(context.isIOS ? 65.h : 115.h),
          customAppBar: AnimatedCrossFade(
            firstCurve: Curves.ease,
            secondCurve: Curves.ease,
            reverseDuration: const Duration(
              milliseconds: NumConstants.globalDuration,
            ),
            duration: const Duration(
              milliseconds: NumConstants.fastDuration,
            ),
            crossFadeState: ProductDetailsCubit.get(context).isProductDetailsVisible
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Container(
              color: AppColors.productDetailsBackground,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 24.w,
                    left: 24.w,
                  ),
                  child: Column(
                    children: [
                      const AppBarProductDetails(
                        showIconMenuWithTitleOnly: true,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: const HeaderTextField(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            secondChild: Padding(
              padding: EdgeInsets.only(
                top: context.mediaQueryOf.padding.top / 1.5,
                right: 30.w,
                left: 30.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlatformIconButton(
                    onPressed: () {
                      ProductDetailsCubit.get(context).showChooseSizeViewFunc();
                    },
                    icon: Icon(
                      PlatformIcons(context).back,
                      color: AppColors.black,
                    ),
                  ),
                  PlatformIconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.string(
                      SVGImageConstants.homeIcon,
                      width: 23.w,
                      height: 21.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
