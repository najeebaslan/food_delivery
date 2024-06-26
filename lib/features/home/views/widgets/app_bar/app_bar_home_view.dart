import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/router/routes_constants.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/styles/app_text_styles.dart';
import 'hero_circle_green_app_bar_home_view.dart';
import 'hero_circle_red_app_bar_home_view.dart';
import 'hero_circle_yellow_app_bar_home_view.dart';

class AppBarHomeView extends StatelessWidget {
  const AppBarHomeView({super.key, required this.redCircleTag});

  final String redCircleTag;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _heroRedAndGreenCircles(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -10.h,
              child: const HeroCircleYellowAppBarHomeView(),
            ),
            const HeroCircleRedAppBarHomeView(),
          ],
        ),
        _goodMorningTitle(),
        const Spacer(),
        _menuIconButton(context),
      ],
    );
  }

  PlatformIconButton _menuIconButton(BuildContext context) {
    return PlatformIconButton(
      onPressed: () => Navigator.pushNamed(
        context,
        AppRoutesConstants.menuView,
      ),
      icon: SvgPicture.asset(
        ImagesConstants.homeMenuIcon,
        height: 14.h,
        width: 24.w,
      ),
    );
  }

  Transform _goodMorningTitle() {
    return Transform.translate(
      offset: Offset(-43.w, 0),
      child: Text.rich(
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
      ),
    );
  }

  Stack _heroRedAndGreenCircles() {
    return Stack(
      children: [
        // Hero(
        //   tag: redCircleTag,
        //   child: Transform.rotate(
        //     angle: 6,
        //     child: SvgPicture.asset(
        //       ImagesConstants.ellipseRed,
        //       height: 32.28.h,
        //       width: 32.28.w,
        //     ),
        //   ),
        // ),
        const HeroCircleGreenAppBarHomeView(),
      ],
    );
  }
}
