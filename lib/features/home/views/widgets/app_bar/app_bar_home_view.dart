import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/router/routes_constants.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/hero_tags_constants.dart';
import '../../../../../core/styles/app_text_styles.dart';
import '../../../../../core/widget/custom_rect_tween.dart';
import '../../../blocs/home_cubit/home_cubit.dart';
import 'hero_green_circle_app_bar_home_view.dart';
import 'hero_red_circle_app_bar_home_view.dart';
import 'hero_yellow_circle_app_bar_home_view.dart';

class AppBarHomeView extends StatelessWidget {
  const AppBarHomeView({
    super.key,
    required this.redCircleTag,
    this.showIconMenuWithTitleOnly = false,
    this.backFrom = NavigateTo.menu,
  });

  final String redCircleTag;
  final bool showIconMenuWithTitleOnly;
  final NavigateTo backFrom;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showIconMenuWithTitleOnly == false) _heroRedAndGreenCircles(),
        if (showIconMenuWithTitleOnly == false)
          SizedBox(
            width: 65.30.w,
            height: 65.30.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -10.h,
                  child: const HeroYellowCircleAppBarHomeView(),
                ),
                const HeroRedCircleAppBarHomeView(),
              ],
            ),
          )
        else
          SizedBox(width: 0.w, height: 65.30.h), // This for make ui responsive
        _GoodMorningTitleWithHero(
          showIconMenuWithTitleOnly: showIconMenuWithTitleOnly,
        ),
        const Spacer(),
        _menuIconButton(context),
      ],
    );
  }

  PlatformIconButton _menuIconButton(BuildContext context) {
    return PlatformIconButton(
      onPressed: () {
        context.read<HomeCubit>().navigateToView(
              NavigateTo.menu,
            );

        Navigator.pushNamed(
          context,
          AppRoutesConstants.menuView,
        );
      },
      icon: SvgPicture.asset(
        ImagesConstants.homeMenuIcon,
        height: 14.h,
        width: 24.w,
      ),
    );
  }

  Stack _heroRedAndGreenCircles() {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(-2, 0),
          child: const Opacity(
            opacity: 0.90,
            child: HeroGreenCircleAppBarHomeView(),
          ),
        ),
        Hero(
          tag: redCircleTag,
          createRectTween: (begin, end) {
            return CustomRectTween(
              begin: begin!,
              end: end!,
            );
          },
          child: Transform.rotate(
            angle: 6,
            child: SvgPicture.asset(
              ImagesConstants.ellipseRed,
              height: 32.28.h,
              width: 32.28.w,
            ),
          ),
        ),
      ],
    );
  }
}

class _GoodMorningTitleWithHero extends StatelessWidget {
  const _GoodMorningTitleWithHero({
    required this.showIconMenuWithTitleOnly,
  });
  final bool showIconMenuWithTitleOnly;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(showIconMenuWithTitleOnly == true ? 10 : -43.w, 0),
      child: Hero(
        tag: HeroTagsConstants.titleAppBarTag,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          if (context.isIOS) {
            return _buildAnimatedBuilder(animation);
          } else {
            return Material(
              color: Colors.transparent,
              child: _buildAnimatedBuilder(animation),
            );
          }
        },
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: _goodMorningTitle(),
      ),
    );
  }

  AnimatedBuilder _buildAnimatedBuilder(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      child: _goodMorningTitle(),
      builder: (context, child) => _goodMorningTitle(),
    );
  }

  Widget _goodMorningTitle() {
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
}
