import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../blocs/home_animation_cubit/home_animation_cubit.dart';
import 'header_text_field.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  @override
  Widget build(BuildContext context) => _buildHeader(context);

  static BlocBuilder _buildHeader(BuildContext context) {
    return BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
      builder: (context, state) {
        return _buildOverlay();
        // context.read<HomeAnimationCubit>().isProductView
        //     ? FadeTransition(
        //         opacity: context.read<HomeAnimationCubit>().opacityColorProductDetails,
        //         child: _buildOverlay(),
        //       )
        //     : _buildOverlay();
      },
    );
  }

  static Overlay _buildOverlay() {
    log('rebuild _buildOverlay');
    return Overlay(
      clipBehavior: Clip.none,
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return Positioned(
              top: (kToolbarHeight * 2).h,
              width: context.width,
              child: ColoredBox(
                color: context.read<HomeAnimationCubit>().isMenuView
                    ? AppColors.homeBackground
                    : AppColors.productDetailsBackground,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Gap(10.h),
                      HeaderTextField(
                        enableAnimation: context.read<HomeAnimationCubit>().isMenuView,
                      ),
                      Gap(10.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        OverlayEntry(
          builder: (context) {
            return Positioned(
              top: 0,
              width: context.width,
              child: ColoredBox(
                color: context.read<HomeAnimationCubit>().isMenuView
                    ? AppColors.homeBackground
                    : AppColors.productDetailsBackground,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Gap(
                        context.isSmallDevice
                            ? (kToolbarHeight / 1.8).h
                            : kToolbarHeight.h,
                      ),
                      _buildAppBar(context),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  static Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 65.30.w, height: 65.30.h), // make appBar responsive
        Transform.translate(
          offset: Offset(-16.w, 1.h),
          child: _goodMorningTitle(),
        ),
        const Spacer(),
        _menuIconButton(
          () => context.read<HomeAnimationCubit>()
            ..startOrReverseMenuAnimation()
            ..changePageView(PageViewEnum.menu),
        ),
      ],
    );
  }

  static Widget _goodMorningTitle() {
    return Text.rich(
      textAlign: TextAlign.left,
      TextSpan(
        children: [
          TextSpan(
            text: 'Good morning, ',
            style: AppTextStyles.font16Black300W.copyWith(
              height: 0,
            ),
          ),
          TextSpan(
            text: 'Jeev jobs',
            style: AppTextStyles.font16Black400W,
          ),
        ],
      ),
    );
  }

  static PlatformIconButton _menuIconButton(VoidCallback onPressed) {
    return PlatformIconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        ImagesConstants.homeMenuIcon,
        height: 14.h,
        width: 24.w,
      ),
    );
  }
}
