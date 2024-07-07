import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/hero_tags_constants.dart';
import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../../core/widget/adaptive_widget/adaptive_app_bar.dart';
import '../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import '../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../home/views/widgets/base_circles/hero_small_red_circle_app_bar_home_view.dart';
import '../home/views/widgets/header_text_field.dart';
import 'choose_size_product_view.dart';
import 'product_details_cubit/product_details_cubit.dart';
import 'widgets/app_bar_product_details.dart';
import 'widgets/base_circles/hero_blue_circle_product.dart';
import 'widgets/base_circles/product_details_list_view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView>
    with SingleTickerProviderStateMixin {
  late ProductDetailsCubit _productCubit;
  @override
  void initState() {
    super.initState();
    _productCubit = ProductDetailsCubit.get(context);
    _productCubit.animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.fastDuration,
      ),
      reverseDuration: const Duration(
        milliseconds: NumConstants.globalDuration,
      ),
    );

    _productCubit.initAnimations();
  }

  Interval opacityCurve = const Interval(
    0.20,
    0.75,
    curve: Curves.fastOutSlowIn,
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return AdaptiveScaffold(
          backgroundColor: AppColors.productDetailsBackground,
          appBar: _buildAppBar(context),
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
                      child: AnimatedBuilder(
                        animation: _productCubit.animationController,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _productCubit.blueCirclePosition,
                            child: _blueCircle(),
                          );
                        },
                      ),
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
                      right: 53.w,
                      child: _yellowCircle(),
                    ),
                    AnimatedBuilder(
                      animation: _productCubit.animationController,
                      builder: (context, child) {
                        return AnimatedCrossFade(
                          firstChild: const ProductDetailsListView(),
                          secondChild: const ChooseSizeProductView(),
                          reverseDuration: Duration(
                            milliseconds: fadeReverseDuration,
                          ),
                          duration: Duration(milliseconds: fadeDuration),
                          crossFadeState:
                              ProductDetailsCubit.get(context).isProductDetailsVisible
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                        );
                      },
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

  AdaptiveAppBar? _buildAppBar(BuildContext context) {
    return AdaptiveAppBar(
      size: Size.fromHeight(context.isIOS ? 65.h : 115.h),
      customAppBar: AnimatedBuilder(
        animation: _productCubit.animationController,
        builder: (context, child) {
          return AnimatedCrossFade(
            alignment: Alignment.topCenter,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlatformIconButton(
                    onPressed: () {
                      ProductDetailsCubit.get(context).reverseInitAnimation();
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
            crossFadeState: _productCubit.isProductDetailsVisible
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            reverseDuration: Duration(milliseconds: fadeReverseDuration),
            duration: Duration(milliseconds: fadeDuration),
          );
        },
      ),
    );
  }

  Widget _redCircle() {
    return AnimatedBuilder(
        animation: _productCubit.animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _productCubit.redCircleOpacity,
            child: SlideTransition(
              position: _productCubit.redCirclePosition,
              child: HeroSmallRedCircleAppBarHomeView(
                height: 48.13.h,
                width: 48.13.w,
                angle: 2,
              ),
            ),
          );
        });
  }

  Widget _yellowCircle() {
    return AnimatedBuilder(
      animation: _productCubit.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _productCubit.yellowCircleOpacity,
          child: SlideTransition(
            position: _productCubit.yellowCirclePosition,
            child: Hero(
              tag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
              createRectTween: (begin, end) {
                return CustomRectTween(
                  begin: begin!,
                  end: end!,
                );
              },
              child: Transform.rotate(
                angle: _productCubit.yellowCircleRotate.value,
                child: SvgPicture.string(
                  SVGImageConstants.yellowCircle,
                  height: _productCubit.yellowCircleSize.value.h,
                  width: _productCubit.yellowCircleSize.value.w,
                ),
              ),
            ),
          ),
        );
      },
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

  int get fadeReverseDuration =>
      opacityCurve.transform(_productCubit.animationController.value).toInt() *
      NumConstants.globalDuration;

  int get fadeDuration =>
      opacityCurve.transform(_productCubit.animationController.value).toInt() * 1000;
}
