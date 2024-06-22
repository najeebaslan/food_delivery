import 'dart:math';

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
          cupertino: (_, __) {
            return CupertinoAppData(
              // home: const MultipleTickerProvider(),
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

// class MultipleTickerProvider extends StatefulWidget {
//   const MultipleTickerProvider({super.key});

//   @override
//   _MultipleTickerProviderState createState() => _MultipleTickerProviderState();
// }

// class _MultipleTickerProviderState extends State<MultipleTickerProvider>
//     with TickerProviderStateMixin {
//   // to animate separately, prepare a multiple AnimationControllers
//   late AnimationController alignController;
//   late AnimationController rotateController;
//   late TweenSequence<Alignment> alignTween;
//   late Tween<double> rotateTween;
//   late Animation<Alignment> alignmAnimation;
//   late Animation<double> rotateAnimation;
//   bool animatingAlign = false;
//   bool animatingRotation = false;

//   @override
//   void initState() {
//     // define duration and vsync for each AnimationController separately
//     rotateController =
//         AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

//     alignController =
//         AnimationController(duration: const Duration(seconds: 3), vsync: this);

//     // define Tween for each Animation
//     rotateTween = Tween(begin: 0, end: 8 * pi);
//     alignTween = TweenSequence<Alignment>(
//       [
//         TweenSequenceItem(
//           tween: Tween(
//             begin: Alignment.center,
//             end: Alignment.topCenter,
//           ),
//           weight: 0.3,
//         ),
//         TweenSequenceItem(
//           tween: Tween(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           weight: 0.4,
//         ),
//         TweenSequenceItem(
//           tween: Tween(
//             begin: Alignment.bottomCenter,
//             end: Alignment.center,
//           ),
//           weight: 0.3,
//         ),
//       ],
//     );

//     // create Animation using each AnimationController
//     alignmAnimation = alignController.drive(alignTween);
//     rotateAnimation = rotateController.drive(rotateTween);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     rotateController.dispose();
//     alignController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.brown[300],
//       //   title: const Text('Multiple Ticker Provider'),
//       // ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // drawer: const MainDrawer(),
//       body: AnimatedBuilder(
//         // wrap Animations with Listenable.merge to listen to multiple animation
//         animation: Listenable.merge([
//           rotateController,
//           alignController,
//         ]),
//         builder: (context, _) {
//           return Stack(
//             fit: StackFit.expand,
//             children: [
//               Align(
//                 alignment: alignmAnimation.value, // bind animation to widget
//                 child: Transform.rotate(
//                   angle: rotateAnimation.value,
//                   child: const Text('Hello world!!'),
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//       // trigger multiple AnimationControllers separately
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//               onPressed: () {
//                 if (!animatingAlign) {
//                   alignController.repeat();
//                   setState(() => animatingAlign = true);
//                   return;
//                 }
//                 alignController.stop();
//                 setState(() => animatingAlign = false);
//               },
//               heroTag: 'align',
//               backgroundColor: Colors.yellow[700],
//               child: const Icon(
//                 Icons.double_arrow,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(width: 20),
//             FloatingActionButton(
//               onPressed: () {
//                 if (!animatingRotation) {
//                   rotateController.repeat();
//                   setState(() => animatingRotation = true);
//                   return;
//                 }
//                 rotateController.stop();
//                 setState(() => animatingRotation = false);
//               },
//               heroTag: 'rotate',
//               backgroundColor: Colors.yellow[700],
//               child: const Icon(
//                 Icons.cyclone,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
