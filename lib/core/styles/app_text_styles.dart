import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._(); // This for not allowed to create new object from this class
  // static final theme = di.sl.get<AppThemes>(); // AppThemes class is a singleton
  static const String defaultFontFamily = 'Roboto';

  static TextStyle font16BlackBold = TextStyle(
    fontSize: 16.sp,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle font16Black400W = TextStyle(
    fontSize: 16.sp,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle font16Black300W = TextStyle(
    fontSize: 16.sp,
    color: AppColors.black,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w300,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle font30Whit300W = TextStyle(
    fontSize: 30.sp,
    color: AppColors.white,
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w300,
    overflow: TextOverflow.ellipsis,
  );
}
