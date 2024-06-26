import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/views/widgets/app_bar/hero_circle_red_app_bar_home_view.dart';

import 'widgets/app_bar/hero_circle_green_app_bar_home_view.dart';
import 'widgets/app_bar/hero_circle_yellow_app_bar_home_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animation;

  static const List<String> titles = [
    "Order History",
    "Offers",
    "Settings",
    "Wallet",
    "Support",
    "Logout",
  ];
  bool openContainer = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1350),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 350.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
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
    return PlatformScaffold(
        backgroundColor: AppColors.backgroundMenuViewColor,
        appBar: PlatformAppBar(
          backgroundColor: AppColors.backgroundMenuViewColor,
          material: (context, platform) {
            return MaterialAppBarData(
              elevation: 0,
              backgroundColor: Colors.transparent,
            );
          },
          cupertino: (context, platform) {
            return CupertinoNavigationBarData(
              noMaterialParent: false,
              border: const Border.fromBorderSide(BorderSide.none),
              backgroundColor: Colors.transparent,
              transitionBetweenRoutes: false,
              automaticallyImplyLeading: false,
            );
          },
          title: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: PlatformIconButton(
              padding: EdgeInsets.only(right: 30.w),
              onPressed: () {
                Navigator.pop(context);
                // _animationController.reverse();
                // Future.delayed(
                //   const Duration(milliseconds: 600),
                //   () => Navigator.pop(context),
                // );
              },
              icon: Icon(
                Icons.close,
                color: AppColors.black,
                size: 25,
              ),
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
              Positioned(
              bottom: 40.h,
              left: 70.w,
              child: HeroCircleYellowAppBarHomeView(
                endTweenAnimation: 3.3,
                heroWidgetAngle: 2.9,
                imageYellowAngle: 3.2,
                heroWidgetHeight: 138.142.h,
                heroWidgetWidth: 138.142.w,
                animatedBuilderChildAngle: (animationValue) {
                  return animationValue > 7 ? 5.3 : 3;
                },
              ),
            ),
            Positioned(
              bottom: 110.h,
              left: 0,
              child: HeroCircleRedAppBarHomeView(
                heroWidgetAngle: 5.3,
                heroWidgetHeight: 248.46.h,
                heroWidgetWidth: 248.46.w,
                animatedBuilderChildAngle: (animationValue) {
                  return animationValue > 7 ? 5.3 : 3;
                },
              ),
            ),
            Positioned(
              bottom: 100.h,
              right: 65.w,
              child: HeroCircleGreenAppBarHomeView(
                heroWidgetWidth: 134.118.w,
                heroWidgetAngle: 5.3,
                animatedBuilderChildAngle: (animationValue) {
                  return animationValue > 7 ? 5.3 : 3;
                },
              ),
            ),
          
          ],
        )
        // AnimatedBuilder(
        //   animation: _animationController,
        //   builder: (context, child) {
        //     return Stack(
        //       clipBehavior: Clip.none,
        //       fit: StackFit.expand,
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.only(right: 24.w, left: 24.w),
        //           child: Align(
        //             alignment: AlignmentDirectional.centerEnd,
        //             child: AnimatedContainer(
        //               // alignment: AlignmentDirectional.centerEnd,
        //               duration: const Duration(milliseconds: 1),
        //               transformAlignment: AlignmentDirectional.center,
        //               curve: Curves.easeInOutBack,
        //               height: _animation.value < 0 ? 0 : _animation.value,
        //               // width: 600,
        //               child: SizedBox(
        //                 height: 500,
        //                 // color: AppColors.red,
        //                 child: SingleChildScrollView(
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.end,
        //                     children: List<Widget>.generate(
        //                       titles.length,
        //                       (index) {
        //                         return Padding(
        //                           padding: EdgeInsets.only(bottom: 14.h),
        //                           child: PlatformTextButton(
        //                             padding: EdgeInsets.zero,
        //                             onPressed: () {},
        //                             child: PlatformText(
        //                               titles[index],
        //                               textAlign: TextAlign.right,
        //                               style: AppTextStyles.font30Black700W,
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         // Opacity(
        //         //   opacity: 0.10,
        //         //   child: Transform.rotate(
        //         //     angle: 2.8,
        //         //     child: SvgPicture.asset(
        //         //       ImagesConstants.ellipseRed,
        //         //       height: 65.30.h,
        //         //       width: 65.30.w,
        //         //     ),
        //         //   ),
        //         // ),
        //         _buildCircleRed()
        //       ],
        //     );
        //   },
        // ),
        );
  }
}
