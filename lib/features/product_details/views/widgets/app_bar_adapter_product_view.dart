import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/features/home/views/widgets/header_text_field.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widget/adaptive_widget/adaptive_app_bar.dart';
import '../../cubit/product_details_cubit.dart';
import 'app_bar_product_details.dart';

class AppBarAdapterProductView extends AdaptiveAppBar {
  const AppBarAdapterProductView({
    super.key,
    required ProductDetailsCubit productCubit,
    required super.size,
  }) : _productCubit = productCubit;

  final ProductDetailsCubit _productCubit;

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppBar(
      size: size,
      customAppBar: AnimatedBuilder(
        animation: _productCubit.animationController,
        builder: (context, child) {
          return AnimatedCrossFade(
            firstChild: SafeArea(
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
            secondChild: Padding(
              padding: EdgeInsets.only(
                top: context.mediaQueryOf.padding.top / 1.5,
                right: 30.w,
                left: 30.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PlatformIconButton(
                        onPressed: () {
                          ProductDetailsCubit.get(context).reverseInitAnimation();
                        },
                        icon: Icon(
                          PlatformIcons(context).back,
                          color: AppColors.black,
                          size: 21.w,
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
                  AnimatedOpacity(
                    opacity: ProductDetailsCubit.get(context)
                        .textChooseSizeOpacity
                        .value
                        .clamp(0.0, 1.0),
                    duration: Duration.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25.w),
                          child: Text(
                            'Spudnut dounut',
                            style: AppTextStyles.font40Black700W.copyWith(
                              height: 0,
                            ),
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 3,
                          margin: EdgeInsets.only(left: 28.w),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF4DB066),
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: _productCubit.isProductDetailsVisible
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            reverseDuration: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 1),
          );
        },
      ),
    );
  }
}
