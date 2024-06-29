import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/views/widgets/app_bar/hero_red_circle_app_bar_home_view.dart';

import '../../core/styles/app_text_styles.dart';
import '../home/views/widgets/app_bar/hero_green_circle_app_bar_home_view.dart';
import '../home/views/widgets/app_bar/hero_yellow_circle_app_bar_home_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityTextAnimation;

  static const List<String> titles = [
    "Order History",
    "Offers",
    "Settings",
    "Wallet",
    "Support",
    "Logout",
  ];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1385),
    );

    _heightAnimation = Tween<double>(
      begin: 20.0.h,
      end: 300.0.h,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    _opacityTextAnimation = Tween<double>(
      begin: 0.0.h,
      end: 1.0.h,
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
      iosContentPadding: true,
      backgroundColor: AppColors.backgroundMenuViewColor,
      appBar: PlatformAppBar(
        backgroundColor: AppColors.backgroundMenuViewColor,
        material: (context, platform) => MaterialAppBarData(
          automaticallyImplyLeading: false,
        ),
        cupertino: (context, platform) {
          return CupertinoNavigationBarData(
            noMaterialParent: false,
            brightness: Brightness.light,
            automaticallyImplyMiddle: false,
            border: const Border.fromBorderSide(BorderSide.none),
            backgroundColor: Colors.transparent,
            transitionBetweenRoutes: false,
            automaticallyImplyLeading: false,
          );
        },
        title: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: EdgeInsets.only(
              right: context.isIOS ? 24.w : 5.w,
            ),
            child: PlatformIconButton(
              onPressed: () => backToHomeView(context),
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.close,
                color: AppColors.black,
                size: 25,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 35.w,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                _buildMenuTitles(constraints),
                Positioned(
                  bottom: 40.h,
                  left: 70.w,
                  child: HeroYellowCircleAppBarHomeView(
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
                  child: HeroRedCircleAppBarHomeView(
                    parameters: HeroRedCircleParameters(
                      angle: 5.3,
                      height: 248.46.h,
                      width: 248.46.w,
                      animatedBuilderChildAngle: (animationValue) {
                        return animationValue > 7 ? 5.3 : 3;
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100.h,
                  right: 65.w,
                  child: HeroGreenCircleAppBarHomeView(
                    heroWidgetWidth: 134.118.w,
                    heroWidgetAngle: 5.3,
                    animatedBuilderChildAngle: (animationValue) {
                      return animationValue > 7 ? 5.3 : 3;
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void backToHomeView(BuildContext context) {
    Navigator.pop(context);
    Future.delayed(
      const Duration(milliseconds: 150),
      () {
        if (mounted) _animationController.reverse();
      },
    );
  }

  Align _buildMenuTitles(BoxConstraints constraints) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Transform.translate(
        offset: Offset(0, -(constraints.maxHeight / 4)),
        child: AnimatedBuilder(
          animation: _heightAnimation,
          builder: (context, child) {
            return Stack(
              alignment: AlignmentDirectional.centerEnd,
              clipBehavior: Clip.none,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: _heightAnimation.value < 0 ? 0 : _heightAnimation.value,
                  width: 200.0.w,
                ),
                ...List.generate(
                  titles.length,
                  (index) {
                    return Positioned(
                      top: (_heightAnimation.value / titles.length) * index,
                      child: Opacity(
                        opacity: textOpacity,
                        child: Text(
                          titles[index],
                          textAlign: TextAlign.right,
                          style: AppTextStyles.font30Black700W,
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  double get textOpacity {
    if (_opacityTextAnimation.value < 0) return 0;
    return _opacityTextAnimation.value > 1 ? 1 : _opacityTextAnimation.value;
  }
}
