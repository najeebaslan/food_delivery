import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/cubit/home_animation_cubit.dart';

import 'core/router/routes_constants.dart';
import 'core/router/routes_manager.dart';

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<HomeAnimationCubit>(
          create: (BuildContext context) => HomeAnimationCubit(),
          child: PlatformApp(
            onGenerateRoute: AppRouter.onGenerateRoute,
            // initialRoute: AppRoutesConstants.splashView,
            initialRoute: AppRoutesConstants.homeView,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1),
              ),
              child: child!,
            ),
            title: 'Food Delivery App',
            debugShowCheckedModeBanner: false,
            cupertino: (_, __) {
              return CupertinoAppData(
                theme: CupertinoThemeData(
                  brightness: Brightness.light,
                  barBackgroundColor: Colors.black,
                  primaryColor: AppColors.kPrimaryColor,
                  scaffoldBackgroundColor: AppColors.background,
                  textTheme: const CupertinoTextThemeData(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
            material: (context, platform) {
              return MaterialAppData(
                theme: ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.light,
                  appBarTheme: const AppBarTheme(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  primaryColor: AppColors.kPrimaryColor,
                  scaffoldBackgroundColor: AppColors.background,
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primaryColor: AppColors.kPrimaryColor,
                  scaffoldBackgroundColor: AppColors.black,
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                      color: Colors.white,
                    ),
                    bodyMedium: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                themeMode: ThemeMode.light,
              );
            },
          ),
        );
      },
    );
  }
}
