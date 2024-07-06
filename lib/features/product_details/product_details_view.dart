import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/hero_tags_constants.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import '../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../home/views/widgets/base_circles/hero_small_red_circle_app_bar_home_view.dart';
import 'choose_size_product_view.dart';
import 'product_details_cubit/product_details_cubit.dart';
import 'widgets/app_bar_adapter_product_and_choose_size.dart';
import 'widgets/base_circles/hero_blue_circle_product.dart';
import 'widgets/base_circles/product_details_list_view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return AdaptiveScaffold(
          backgroundColor: AppColors.productDetailsBackground,
          appBar: const AppBarAdapterProductDetailsAndChooseSize(),
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
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
                    AnimatedCrossFade(
                      firstChild: const ProductDetailsListView(),
                      secondChild: const ChooseSizeProductView(),
                      firstCurve: Curves.ease,
                      secondCurve: Curves.ease,
                      reverseDuration: const Duration(
                        milliseconds: NumConstants.globalDuration,
                      ),
                      duration: const Duration(
                        milliseconds: NumConstants.fastDuration,
                      ),
                      crossFadeState:
                          ProductDetailsCubit.get(context).isProductDetailsVisible
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
      child: SvgPicture.string(
        SVGImageConstants.yellowCircle,
        height: 78.358.h,
        width: 78.358.w,
      ),
    );
  }

  Widget _blueCircle() {
    return HeroBlueCircleProduct(
      parameters: HeroRedCircleParameters(
        showProductDetails: ProductDetailsCubit.get(context).isProductDetailsVisible,
        height: 195.023.h,
        width: 195.023.w,
        angle: 4,
        animatedBuilderChildAngle: (animationValue) {
          return animationValue > 1 ? 4 : 3;
        },
      ),
    );
  }
}
