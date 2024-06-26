import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/router/routes_constants.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widget/custom_rect_tween.dart';

class AppBarHomeView extends StatelessWidget {
  const AppBarHomeView({super.key, required this.redCircleTag});
  final String redCircleTag;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Hero(
              tag: redCircleTag,
              child: Transform.rotate(
                angle: 6,
                child: SvgPicture.asset(
                  ImagesConstants.ellipseRed,
                  height: 32.28.h,
                  width: 32.28.w,
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -10,
                  child: Transform.rotate(
                    angle: 6.2,
                    child: SvgPicture.asset(
                      ImagesConstants.onboardingCircleBoldYellow,
                      height: 32.28.h,
                      width: 32.28.w,
                    ),
                  ),
                ),
                Hero(
                  tag: 'tag',
                  transitionOnUserGestures: true,
                  createRectTween: (begin, end) {
                    return CustomRectTween(
                      begin: begin!,
                      end: end!,
                    );
                  },
                  flightShuttleBuilder: (_, Animation<double> animation, __, ___, ____) {
                    final rotationAnimation = Tween<double>(
                      begin: 0.0,
                      end: 2.3,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOutBack,
                      ),
                    );

                    return AnimatedBuilder(
                      animation: rotationAnimation,
                      child: Transform.rotate(
                        angle: rotationAnimation.value > 0.7 ? 3 : -2.3,
                        child: Opacity(
                          opacity: 0.10,
                          child: SvgPicture.asset(
                            ImagesConstants.ellipseRed,
                            height: 65.30.h,
                            width: 65.30.w,
                          ),
                        ),
                      ),
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..rotateZ(
                              rotationAnimation.value,
                            ),
                          alignment: Alignment.center,
                          child: child,
                        );
                      },
                    );
                  },
                  child: Opacity(
                    opacity: 0.10,
                    child: Transform.rotate(
                      angle: 3,
                      child: SvgPicture.asset(
                        ImagesConstants.ellipseRed,
                        height: 65.30.h,
                        width: 65.30.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(-43.w, 0),
              child: Text.rich(
                textAlign: TextAlign.left,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Good moring, ',
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
            ),
            const Spacer(),
            PlatformIconButton(
              onPressed: () {
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
            ),
          ],
        ),
      ],
    );
  }
}
