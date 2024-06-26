import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:food_delivery/food_delivery.dart';

import 'core/constants/assets_constants.dart';
import 'core/utils/bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // Whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
  // This line for fix hide text bugs in screen_utils in release mode
  await ScreenUtil.ensureScreenSize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await cacheSvgImagesSplashView();

  runApp(const FoodDeliveryApp());
}

Future<void> cacheSvgImagesSplashView() async {
  List<String> splashViewImagesUrl = [
    ImagesConstants.ellipseGreen,
    ImagesConstants.friesBlue,
    ImagesConstants.ellipseYellow,
    ImagesConstants.ellipseRed,
    ImagesConstants.ellipseSmall,
    ImagesConstants.burgerBlueCircle,
  ];
  for (String imageUrl in splashViewImagesUrl) {
    final svg.SvgAssetLoader loader = svg.SvgAssetLoader(imageUrl);

    await svg.Cache().putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }
}
// /*
// home_box_donut
//  cola_isometric
//  mayo_isometric

// //  */

// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';

// import 'core/constants/assets_constants.dart';

// void main() => runApp(const MyApp());

// Color kCoolOrange = const Color(0xFFF81934);
// Color kCoolOrange2 = const Color(0xFFF66F3F);

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const PlatformApp(
//       title: 'Custom Hero Animation 2',
//       home: Screen1(),
//     );
//   }
// }

// class RatingBar extends StatelessWidget {
//   final bool isFirst;

//   final double size;

//   const RatingBar({
//     super.key,
//     required this.isFirst,
//     required this.size,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: 'ratingStar',
//       createRectTween: (begin, end) {
//         return CustomRectTween(
//           begin: begin!,
//           end: end!,
//         );
//       },

//       flightShuttleBuilder:
//           (BuildContext flightContext, Animation<double> animation, _, __, ___) {
//         final rotationAnimation = Tween<double>(
//           begin: 0.0, // This value should match the first Hero
//           end: 1, // This value should match the second Hero
//         ).animate(
//           CurvedAnimation(
//             parent: animation,
//             curve: Curves.easeInOutBack,
//           ),
//         );

//         // 3️⃣ ✈️ The widget animating in between
//         return AnimatedBuilder(
//           animation: rotationAnimation,
//           child: Platform.isAndroid ? Material(child: this) : this,
//           builder: (context, child) {
//             return

//                 // AnimatedRotation(
//                 //   turns: rotationAnimation.value * 2,
//                 //   duration: const Duration(milliseconds: 1350),
//                 //   alignment: Alignment.center,
//                 //   curve: Curves.easeInOutBack,
//                 //   child: this,
//                 // );

//                 Transform(
//               transform: Matrix4.identity()
//                 ..rotateZ(
//                   isFirst == false ? rotationAnimation.value * pi : 6.4,
//                 ),
//               alignment: Alignment.center,
//               child: Transform.rotate(
//                 alignment: Alignment.center,
//                 angle: !isFirst ? 3 : 6.4,
//                 child: this,
//               ),
//             );
//           },
//         );
//       },
//       child: Transform.rotate(
//         alignment: Alignment.center,
//         angle: !isFirst ? 4 : 6.4,
//         child: SvgPicture.asset(
//           ImagesConstants.ellipseRed,
//           height: size,
//           width: size,
//         ),
//       ),

//       // Container(
//       //   height: size,
//       //   width: size,
//       //   color: Colors.red,
//       //   child: const Text('data'),
//       // ),
//     );
//     // Platform.isAndroid ? Material(child: this) : this;
//     // },
//     // createRectTween: (begin, end) {
//     //   return CustomRectTween(
//     //     begin: begin!,
//     //     end: end!,
//     //   );
//     // },
//     // child:

//     // Container(
//     //   height: size,
//     //   width: size,
//     //   color: Colors.red,
//     //   child: const Text('data'),
//     // )
//     //     Icon(
//     //   Icons.star,
//     //   color: kCoolOrange,
//     //   size: size,
//     // ),

//     // )
//   }
// }

// class CustomRectTween extends RectTween {
//   CustomRectTween({required Rect begin, required Rect end})
//       : super(begin: begin, end: end);

//   @override
//   Rect lerp(double t) {
//     double startX = begin!.left;
//     double startY = begin!.top;
//     double startWidth = begin!.width;
//     double startHeight = begin!.height;

//     double endX = end!.left;
//     double endY = end!.top;
//     double endWidth = end!.width;
//     double endHeight = end!.height;

//     double easeInOutBackValue = Curves.easeInOutBack.transform(t);

//     double animatedX = startX + (endX - startX) * easeInOutBackValue;
//     double animatedY = startY + (endY - startY) * easeInOutBackValue;
//     double animatedWidth = startWidth + (endWidth - startWidth) * easeInOutBackValue;
//     double animatedHeight = startHeight + (endHeight - startHeight) * easeInOutBackValue;

//     return Rect.fromLTWH(animatedX, animatedY, animatedWidth, animatedHeight);
//   }
// }

// class Screen1 extends StatelessWidget {
//   const Screen1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PlatformScaffold(
//       body: Column(
//         children: <Widget>[
//           const Gap(100),
//           const Center(
//             child: RatingBar(
//               size: 150,
//               isFirst: true,
//             ),
//           ),
//           const SizedBox(
//             height: 60,
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: kCoolOrange2,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 PageRouteBuilder(
//                   // transitionDuration: const Duration(milliseconds: 1350),
//                   // reverseTransitionDuration: const Duration(milliseconds: 1350),
//                   transitionDuration: const Duration(seconds: 3),
//                   reverseTransitionDuration: const Duration(seconds: 3),
//                   pageBuilder: (context, animation, secondaryAnimation) {
//                     return FadeTransition(
//                       opacity: animation,
//                       child: const Screen2(),
//                     );
//                   },
//                 ),
//               );
//             },
//             child: PlatformText('Go to next screen'),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Screen2 extends StatelessWidget {
//   const Screen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PlatformScaffold(
//       backgroundColor: Colors.red.shade100,
//       appBar: PlatformAppBar(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Center(
//             child:
//                 // Hero(
//                 //     tag: 'ratingStar',
//                 //     createRectTween: (begin, end) {
//                 //       return CustomRectTween(
//                 //         begin: begin!,
//                 //         end: end!,
//                 //       );
//                 //     },
//                 //     flightShuttleBuilder: (BuildContext flightContext,
//                 //         Animation<double> animation, _, __, ___) {
//                 //       final rotationAnimation = Tween<double>(
//                 //         begin: 0.0, // This value should match the first Hero
//                 //         end: 1, // This value should match the second Hero
//                 //       ).animate(
//                 //         CurvedAnimation(
//                 //           parent: animation,
//                 //           curve: Curves.easeInOutBack,
//                 //         ),
//                 //       );

//                 //       // 3️⃣ ✈️ The widget animating in between
//                 //       return AnimatedBuilder(
//                 //         animation: rotationAnimation,
//                 //         child: Platform.isAndroid ? Material(child: this) : this,
//                 //         builder: (context, child) {
//                 //           return Transform(
//                 //             transform: Matrix4.identity()
//                 //               ..rotateZ(
//                 //                 rotationAnimation.value * pi,
//                 //               ),
//                 //             alignment: Alignment.center,
//                 //             child: SvgPicture.asset(
//                 //               ImagesConstants.ellipseRed,
//                 //               height: 300,
//                 //               width: 300,
//                 //             ),
//                 //           );
//                 //         },
//                 //       );
//                 //     },
//                 //     child: SvgPicture.asset(
//                 //       ImagesConstants.ellipseRed,
//                 //       height: 300,
//                 //       width: 300,
//                 //     )
//                 //     // Container(
//                 //     //   height: size,
//                 //     //   width: size,
//                 //     //   color: Colors.red,
//                 //     //   child: const Text('data'),
//                 //     // ),

//                 //     )
//                 RatingBar(
//               size: 300,
//               isFirst: false,
//             ),
//           ),
//           // const Gap(200),
//           ElevatedButton(
//             onPressed: () {},
//             child: const Text('data'),
//           )
//         ],
//       ),
//     );
//   }
// }
