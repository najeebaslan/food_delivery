import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/features/home/views/menu_view.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_text_styles.dart';

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
            Column(
              children: [
                Transform.translate(
                  offset: Offset(-20.w, 5.h),
                  child: Transform.rotate(
                    angle: 6,
                    child: SvgPicture.asset(
                      ImagesConstants.onboardingCircleBoldYellow,
                      height: 32.28.h,
                      width: 32.28.w,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(1.w, -20.h),
                  child: Opacity(
                    opacity: 0.10,
                    child: Transform.rotate(
                      angle: 2.8,
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
                Navigator.push(context, _createRoute());
                // Navigator.pushNamed(
                //   context,
                //   AppRoutesConstants.menuView,
                // );
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

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutBack;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: const MenuView()
            // Stack(
            //   children: [
            //     Transform.translate(
            //       offset: Offset(1.w, -20.h),
            //       child: Opacity(
            //         opacity: 0.10,
            //         child: Transform.rotate(
            //           angle: 2.8,
            //           child: SvgPicture.asset(
            //             ImagesConstants.ellipseRed,
            //             height: 65.30.h,
            //             width: 65.30.w,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            );
        // return const MenuView();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // const begin = Offset(0.0, 1.0);
        // const end = Offset.zero;
        // const curve = Curves.easeInOutBack;

        // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return const MenuView();
      },
    );
  }
}
