import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/widget/custom_rect_tween.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/hero_tags_constants.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import '../../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../../home/views/widgets/base_circles/hero_small_red_circle_app_bar_home_view.dart';
import '../product_details_cubit/product_details_cubit.dart';
import 'choose_size_views/choose_size_product_view.dart';
import 'widgets/app_bar_adapter_product_view.dart';
import 'widgets/base_circles/hero_blue_circle_product.dart';
import 'widgets/product_details_list_view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView>
    with TickerProviderStateMixin {
  late ProductDetailsCubit _productCubit;
  @override
  void initState() {
    super.initState();
    _productCubit = ProductDetailsCubit.get(context);
    _productCubit.animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration450,
      ),
      reverseDuration: const Duration(
        milliseconds: NumConstants.duration1350,
      ),
    );
    _productCubit.chooseSizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumConstants.duration900),
    );
    _productCubit
      ..initAnimations()
      ..initChooseSizeAnimation();
  }

  @override
  void dispose() {
    _productCubit.disposeAnimationControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: Listenable.merge([
            _productCubit.animationController,
            _productCubit.chooseSizeAnimationController,
          ]),
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
                onTap: () => _onBackToHomeView(context),
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
                        // height: _productCubit.redCircleSize.value.h / 1.5,
                        // width: _productCubit.redCircleSize.value.w,
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
        child: Transform.rotate(
          angle: _productCubit.rotateRedCircle.value,
          alignment: Alignment.center,
          child: AnimatedCrossFade(
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
                    key: topChildKey,
                    child: topChild,
                  ),
                  Positioned(
                    key: bottomChildKey,
                    child: bottomChild,
                  ),
                ],
              );
            },
            firstChild: HeroSmallRedCircleAppBarHomeView(
              height: _productCubit.redCircleSize.value.h,
              width: _productCubit.redCircleSize.value.w,
              angle: 2,
            ),
            secondChild: Transform.rotate(
              key: UniqueKey(),
              angle: 3.2,
              child: SvgPicture.asset(
                ImagesConstants.fatBorderCircle,
                height: _productCubit.redCircleSize.value,
                width: _productCubit.redCircleSize.value,
                colorFilter: ColorFilter.mode(
                  AppColors.nearBlue.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
            crossFadeState: _productCubit.chooseSizeAnimationController.value <
                    _productCubit.onCrossFadeRedCircleValue
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(
              milliseconds: 200,
            ),
          ),
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
        showProductDetails: _productCubit.isProductDetailsVisible,
        height: 195.023.h,
        width: 195.023.w,
        angle: 4,
        animatedBuilderChildAngle: (animationValue) {
          return animationValue > 1 ? 4 : 3;
        },
      ),
    );
  }

  void _onBackToHomeView(BuildContext context) {
    if (_productCubit.isProductDetailsVisible) {
      Navigator.pop(context);
    }
  }
}
