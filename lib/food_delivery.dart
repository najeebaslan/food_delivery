import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';

import 'core/router/routes_constants.dart';
import 'core/router/routes_manager.dart';

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return PlatformApp(
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRoutesConstants.splashView,
          // initialRoute: AppRoutesConstants.homeView,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: child!,
          ),
          title: 'Food Delivery App',
          debugShowCheckedModeBanner: false,
          cupertino: (_, __) => CupertinoAppData(
            theme: CupertinoThemeData(
              brightness: Brightness.light,
              barBackgroundColor: Colors.black,
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: AppColors.background,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          material: (context, platform) {
            return MaterialAppData(
              theme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: kPrimaryColor,
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
                primaryColor: kPrimaryColor,
                scaffoldBackgroundColor: AppColors.black,
                textTheme: TextTheme(
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