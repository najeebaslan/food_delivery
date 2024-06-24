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
/*
home_box_donut
 cola_isometric
 mayo_isometric

//  */

// import 'package:flutter/material.dart';

// class ExpandingContainer extends StatefulWidget {
//   final Widget child;
//   final bool isOpen;
//   final Duration duration;

//   const ExpandingContainer({
//     super.key,
//     required this.child,
//     required this.isOpen,
//     this.duration = const Duration(milliseconds: 200),
//   });

//   @override
//   _ExpandingContainerState createState() => _ExpandingContainerState();
// }

// class _ExpandingContainerState extends State<ExpandingContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _heightAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: widget.duration,
//       vsync: this,
//     );
//     _heightAnimation = Tween<double>(
//       begin: 0.0,
//       end: 300.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOutBack,
//       ),
//     );

//     // if (widget.isOpen) {
//     //   _animationController.forward();
//     // }
//   }

//   // @override
//   // void didUpdateWidget(covariant ExpandingContainer oldWidget) {
//   //   super.didUpdateWidget(oldWidget);
//   //   if (widget.isOpen != oldWidget.isOpen) {
//   //     if (widget.isOpen) {
//   //       _animationController.forward();
//   //     } else {
//   //       _animationController.reverse();
//   //     }
//   //   }
//   // }
//   bool isOpen = false;
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return Column(
//           children: [
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return Column(
//                   children: [
//                     ...List.generate(4, (index) {
//                       return Transform.translate(
//                         offset: Offset(
//                           0,
//                           _heightAnimation.value,
//                         ),
//                         child: const Text(
//                           'najeeb aslan',
//                           style: TextStyle(
//                             fontSize: 30,
//                             color: Colors.red,
//                           ),
//                         ),
//                       );
//                     }),
//                     ...List.generate(4, (index) {
//                       return Transform.translate(
//                         offset: Offset(
//                           0,
//                           -_heightAnimation.value,
//                         ),
//                         child: const Text(
//                           'najeeb aslan',
//                           style: TextStyle(
//                             fontSize: 30,
//                             color: Colors.red,
//                           ),
//                         ),
//                       );
//                     })
//                   ],
//                 );
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (isOpen == true) {
//                   _animationController.reverse();
//                   isOpen = false;
//                 } else {
//                   _animationController.forward();

//                   isOpen = true;
//                 }
//                 // _animationController.addStatusListener((listener) {
//                 //   if (listener == AnimationStatus.completed) {
//                 //   } else {}
//                 // });
//               },
//               child: const Text('Open'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final bool _isOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ExpandingContainer(
//                 isOpen: _isOpen,
//                 child: const Text('This is the content'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
