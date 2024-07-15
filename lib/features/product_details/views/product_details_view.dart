import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/features/product_details/views/widgets/base_circles/choose_size_blue_circle_animation.dart';
import 'package:food_delivery/features/product_details/views/widgets/base_circles/choose_size_red_circle_animation.dart';
import 'package:food_delivery/features/product_details/views/widgets/base_circles/choose_size_yellow_circle_animation.dart';

import '../../../core/styles/app_text_styles.dart';
import '../../../core/widget/adaptive_widget/adaptive_scaffold.dart';
import '../product_details_cubit/product_details_cubit.dart';
import 'choose_size_views/choose_size_product_view.dart';
import 'widgets/app_bar_adapter_product_view.dart';
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
                        child: const ChooseSizeBlueCircleAnimation(),
                      ),
                      Positioned(
                        width: 235.w,
                        height: 37.h,
                        top: context.isIOS ? 100.h : 60.h,
                        left: 0.w,
                        child: _titleProduct(),
                      ),
                      Positioned(
                        top: context.isIOS ? 120.h : 80.h,
                        right: 30.w,
                        child: const ChooseSizeRedCircleAnimation(),
                      ),
                      Positioned(
                        top: context.isIOS ? 80.h : 40.h,
                        right: 53.w,
                        child: const ChooseSizeYellowCircleAnimation(),
                      ),
                      _bodyProductView(),
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

  AnimatedCrossFade _bodyProductView() {
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

  Widget _titleProduct() {
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

  void _onBackToHomeView(BuildContext context) {
    if (_productCubit.isProductDetailsVisible) {
      Navigator.pop(context);
    }
  }
}
