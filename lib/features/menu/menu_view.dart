import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

import '../../core/styles/app_colors.dart';
import '../../core/styles/app_text_styles.dart';
import '../home/blocs/home_animation_cubit/home_animation_cubit.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key, required this.homeAnimationCubit});

  final HomeAnimationCubit homeAnimationCubit;

  double topPositionTitle(int index) {
    return (homeAnimationCubit.heightTitlesMenuAnimation.value / titles.length) * index;
  }

  double get heightTitle {
    return homeAnimationCubit.heightTitlesMenuAnimation.value > 0
        ? homeAnimationCubit.heightTitlesMenuAnimation.value
        : 0;
  }

  static const List<String> titles = [
    "Order History",
    "Offers",
    "Settings",
    "Wallet",
    "Support",
    "Logout",
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: homeAnimationCubit.menuAnimationController,
          builder: (context, child) {
            return Container(
              alignment: AlignmentDirectional.centerEnd,
              height: context.height,
              width: context.width,
              color: AppColors.backgroundMenuViewColor,
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 70.h,
                        right: 24.w,
                      ),
                      child: PlatformIconButton(
                        onPressed: () {
                          homeAnimationCubit.startOrReverseMenuAnimation();
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.close,
                          color: AppColors.black,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -constraints.maxHeight / 6.5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 35.w,
                      ),
                      child: SizedBox(
                        height: heightTitle,
                        width: 200.0.w,
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: List.generate(
                            titles.length,
                            (index) {
                              return Positioned(
                                top: topPositionTitle(index),
                                child: Text(
                                  titles[index],
                                  textAlign: TextAlign.right,
                                  style: AppTextStyles.font30Black700W,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
