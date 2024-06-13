import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';

import 'core/styles/app_text_styles.dart';
import 'views/home_view.dart';

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Platform.isAndroid ? const Size(414, 896) : const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.2),
            ),
            child: child!,
          ),
          title: 'Food Delivery App',
          debugShowCheckedModeBanner: false,
          theme: appThemeData(context),
          home: const HomeView(),
        );
      },
    );
  }

  ThemeData appThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimaryColor),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        elevation: 0,
      ),
      textTheme: TextTheme(
        titleLarge: context.textTheme.titleLarge?.copyWith(
          fontFamily: AppTextStyles.defaultFontFamily,
          overflow: TextOverflow.ellipsis,
          color: AppColors.black,
          height: 1.6,
        ),
        titleMedium: context.textTheme.titleMedium?.copyWith(
          overflow: TextOverflow.ellipsis,
          fontFamily: AppTextStyles.defaultFontFamily,
          color: AppColors.black,
          height: 1.6,
        ),
        // titleSmall: context.textTheme.titleSmall?.copyWith(
        //   overflow: TextOverflow.ellipsis,
        //   fontFamily: AppTextStyles.defaultFontFamily,
        //   color: AppColors.nearBlack,
        //   height: 1.6,
        // ),
        // bodyLarge: context.textTheme.bodyLarge?.copyWith(
        //   overflow: TextOverflow.ellipsis,
        //   fontFamily: AppTextStyles.defaultFontFamily,
        //   color: AppColors.nearBlack,
        //   height: 1.6,
        // ),
        // bodySmall: context.textTheme.bodySmall?.copyWith(
        //   overflow: TextOverflow.ellipsis,
        //   fontFamily: AppTextStyles.defaultFontFamily,
        //   color: AppColors.nearBlack,
        //   height: 1.6,
        // ),
        // bodyMedium: context.textTheme.bodyMedium?.copyWith(
        //   overflow: TextOverflow.ellipsis,
        //   fontFamily: AppTextStyles.defaultFontFamily,
        //   color: AppColors.nearBlack,
        //   height: 1.6,
        // ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.white,
        filled: true,
        contentPadding: EdgeInsets.only(
          left: 30.w,
          top: 10.h,
          right: 30.w,
          bottom: 10.h,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: kPrimaryColor)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.h,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0.h,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0.h,
          ),
        ),
        errorStyle: context.textTheme.bodySmall?.copyWith(
          color: AppColors.errorColor,
        ),
        hintStyle: context.textTheme.bodySmall?.copyWith(
          color: AppColors.black,
        ),
        labelStyle: context.textTheme.bodySmall?.copyWith(
          color: AppColors.black,
        ),
        suffixStyle: context.textTheme.bodyLarge?.copyWith(
          color: AppColors.black,
        ),
        prefixStyle: context.textTheme.bodyLarge?.copyWith(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      scaffoldBackgroundColor: AppColors.background,
      brightness: Brightness.light,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: kPrimaryColor,
        ),
      ),
    );
  }
}
