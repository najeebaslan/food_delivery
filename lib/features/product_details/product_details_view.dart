import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/hero_tags_constants.dart';
import '../../core/styles/app_text_styles.dart';
import '../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import '../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../home/views/widgets/base_circles/hero_small_red_circle_app_bar_home_view.dart';
import 'product_details_cubit/product_details_cubit.dart';
import 'widgets/app_bar_adapter_product_view.dart';
import 'widgets/base_circles/hero_blue_circle_product.dart';
import 'widgets/choose_size_views/choose_size_product_view.dart';
import 'widgets/product_details_list_view.dart';

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

  @override
  void dispose() {
    _productCubit.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _productCubit.animationController,
          builder: (context, child) {
            return AdaptiveScaffold(
              backgroundColor: _productCubit.backgroundColorAnimation.value,
              appBar: AppBarAdapterProductView(
                size: Size.fromHeight(
                  context.isIOS ? 65.h : 115.h,
                ),
                productCubit: _productCubit,
              ),
              body: GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  // if (ProductDetailsCubit.get(context).isProductDetailsVisible) {
                  // }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 24.w,
                    left: 24.w,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: context.isIOS ? 50.h : 10.h,
                        left: -70.w,
                        child: SlideTransition(
                          position: _productCubit.blueCirclePosition,
                          child: _blueCircle(),
                        ),
                      ),
                      Positioned(
                        width: 235.w,
                        height: 37.h,
                        top: context.isIOS ? 100.h : 60.h,
                        left: 0.w,
                        child: _buildTitleProduct(),
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
                      _buildBodyProductView(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  AnimatedCrossFade _buildBodyProductView() {
    return AnimatedCrossFade(
      layoutBuilder: (
        topChild,
        topChildKey,
        bottomChild,
        bottomChildKey,
      ) {
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              key: bottomChildKey,
              child: bottomChild,
            ),
            Positioned(
              key: topChildKey,
              child: topChild,
            ),
          ],
        );
      },
      firstChild: const ProductDetailsListView(),
      secondChild: const ChooseSizeProductView(),
      reverseDuration: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 1),
      crossFadeState: _productCubit.isProductDetailsVisible
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }

  Widget _buildTitleProduct() {
    return _productCubit.isProductDetailsVisible
        ? AnimatedOpacity(
            duration: Duration.zero,
            opacity: _productCubit.titleProductOpacity.value,
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
          )
        : const SizedBox.shrink();
  }

  Widget _redCircle() {
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
  }

  Widget _yellowCircle() {
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
