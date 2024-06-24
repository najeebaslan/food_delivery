import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
  });
  final String title;
  final VoidCallback onPressed;

  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 322.w,
      height: 66.h,
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
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        height: 0,
      ),
    );
  }
}
