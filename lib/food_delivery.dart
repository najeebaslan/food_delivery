import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/blocs/home_animation_cubit/home_animation_cubit.dart';

import 'core/router/routes_constants.dart';
import 'core/router/routes_manager.dart';
import 'features/home/blocs/home_cubit/home_cubit.dart';

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
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit()
            ..navigateToView(
              NavigateTo.menu,
            ),
          child: BlocProvider<HomeAnimationCubit>(
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
                  // home: const MyPage(),
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
                    // textTheme: TextTheme(
                    //   bodyLarge: TextStyle(
                    //     color: Colors.white,
                    //   ),
                    //   bodyMedium: TextStyle(
                    //     color: Colors.white,
                    //   ),
                    // ),
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
                  themeMode: ThemeMode.system,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/* 
- scaffold
- MaterialApp
- Theme
- ElevatedButton
- switch
-alertDialog
- alertAction
-CircularProgressIndicator
-TextButton
-Navigator.pageRoute
- bottomSheet
-alertActionSheet
- pick date time
- slider
-navigationBar

 */

// Responsive ui
/* 

FractionallySizedBox
LayoutBuilder
AlignmentDirectional
Expanded
Flexible
FittedBox

  */
