import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._(); // This for not allowed to create new object from this class
  // static final theme = di.sl.get<AppThemes>(); // AppThemes class is a singleton
  static const String defaultFontFamily = 'IBM Plex Sans Arabic';
  static const String fontFamilyMedium = 'IBM Plex Sans Arabic Medium';
  static const String fontFamilySemiBold = 'IBM Plex Sans Arabic SemiBold';

  static TextStyle small = TextStyle(
    fontSize: 14.sp,
    color: AppColors.kPrimaryColor.withOpacity(0.5),
    fontFamily: defaultFontFamily,
    fontWeight: FontWeight.w300,
    overflow: TextOverflow.ellipsis,
  );
}
