import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../blocs/home_animation_cubit/home_animation_cubit.dart';
import '../../../product_details/views/widgets/app_bar_product_details.dart';
import 'header_text_field.dart';

class HomeViewHeader extends StatefulWidget {
  const HomeViewHeader({super.key, this.showIconMenuWithTitleOnly = false});
  final bool showIconMenuWithTitleOnly;
  @override
  State<HomeViewHeader> createState() => _HomeViewHeaderState();
}

class _HomeViewHeaderState extends State<HomeViewHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    setupAnimationSlider();
  }

  void setupAnimationSlider() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: const Offset(0, 0.01),
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
      builder: (context, state) {
        return Overlay(
          clipBehavior: Clip.none,
          initialEntries: [
            OverlayEntry(
              builder: (context) {
                return Positioned(
                  top: 0,
                  width: context.width,
                  child: ColoredBox(
                    color: context.read<HomeAnimationCubit>().isMenuViewOrEmpty
                        ? AppColors.homeBackground
                        : AppColors.productDetailsBackground,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          Gap(context.mediaQueryOf.padding.top), // make appBar responsive
                          _buildAppBar(context),
                          _buildTextFieldWithAnimation()
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }

  AnimatedBuilder _buildTextFieldWithAnimation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: const HeaderTextField(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 65.30.w, height: 65.30.h), // make appBar responsive

        const GoodMorningTitleWithHero(
          showIconMenuWithTitleOnly: false,
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

  PlatformIconButton _menuIconButton(VoidCallback onPressed) {
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
