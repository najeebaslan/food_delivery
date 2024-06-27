import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';

import 'core/router/routes_constants.dart';
import 'core/router/routes_manager.dart';
import 'features/home/views/widgets/app_bar/app_bar_home_view.dart';

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
          cupertino: (_, __) {
            return CupertinoAppData(
              // home: const TestAnimations(),
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
                brightness: Brightness.dark,
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

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primaryColor: Colors.white),
//       home: const HeroAnimation(),
//     );
//   }
// }

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 4.0;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Screen 1'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: PhotoHero(
              photo:
                  'https://www.emanprague.com/en/wp-content/uploads/2018/05/flutter_eman_blog.png',
              fit: BoxFit.contain,
              onTap: () {
                // Navigator.of(context).pop();
              },
            ),
          ),
          // PhotoHero(
          //   photo:
          //       'https://www.emanprague.com/en/wp-content/uploads/2018/05/flutter_eman_blog.png',
          //   width: 400.0,
          //   height: 500.0,
          //   fit: BoxFit.cover,
          //   onTap: () {},
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return Scaffold(
                        backgroundColor: Colors.black,
                        // appBar: AppBar(
                        //   title: const Text('Screen 2'),
                        // ),
                        body: Center(
                          child: PhotoHero(
                            photo:
                                'https://www.emanprague.com/en/wp-content/uploads/2018/05/flutter_eman_blog.png',
                            fit: BoxFit.contain,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ));
                  },
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text('ElevatedButton'),
          ),
        ],
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {super.key,
      required this.photo,
      required this.onTap,
      this.width,
      this.height,
      required this.fit});

  final String photo;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Hero(
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          final Widget hero = flightDirection == HeroFlightDirection.push
              ? fromHeroContext.widget
              : toHeroContext.widget;
          return hero;
        },
        tag: photo,
        child: Platform.isAndroid
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: Image.network(
                    photo,
                    fit: fit,
                  ),
                ),
              )
            : CupertinoButton(
                onPressed: onTap,
                child: Image.network(
                  photo,
                  fit: fit,
                ),
              ),
      ),
    );
  }
}
