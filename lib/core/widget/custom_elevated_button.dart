import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';

import '../styles/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
  });
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 322.w,
      height: height ?? 66.h,
      child: PlatformElevatedButton(
        cupertino: (context, platform) {
          return CupertinoElevatedButtonData(
            borderRadius: BorderRadius.circular(20.r),
            color: backgroundColor ?? AppColors.blue,
            disabledColor: AppColors.red,
            onPressed: onPressed,
            originalStyle: true,
            child: buildText(title),
          );
        },
        material: (context, platform) {
          return MaterialElevatedButtonData(
            child: buildText(title),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? AppColors.blue,
              disabledBackgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  PlatformText buildText(String title) {
    return PlatformText(
      title,
      style: AppTextStyles.font20White700W.copyWith(
        height: 0,
      ),
    );
  }
}
