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

// import 'dart:developer';
// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:food_delivery/core/extensions/context_extension.dart';
// import 'package:food_delivery/core/styles/app_colors.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'stackoverflow question',
//       home: SafeArea(
//         top: false,
//         bottom: true,
//         child: TweenSequenceExample(),
//       ),
//     );
//   }
// }

// class TweenSequenceExample extends StatefulWidget {
//   const TweenSequenceExample({super.key});

//   @override
//   State<TweenSequenceExample> createState() => _TweenSequenceExampleState();
// }

// class _TweenSequenceExampleState extends State<TweenSequenceExample>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Color?> _colorAnimation;
//   late Animation<double> _sizeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 7),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0),
//       end: const Offset(
//         math.pi * 1,
//         math.pi * 5,
//       ),
//     ).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOutBack,
//       ),
//     );
//     _colorAnimation = TweenSequence<Color?>(
//       [
//         TweenSequenceItem<Color?>(
//           tween: ColorTween(
//             begin: Colors.red,
//             end: Colors.green,
//           ),
//           weight: 50.0, // Weight determines animation duration for this step
//         ),
//         TweenSequenceItem<Color?>(
//           tween: ColorTween(
//             begin: Colors.green,
//             end: Colors.blue,
//           ),
//           weight: 50.0,
//         ),
//       ],
//     ).animate(_controller);

//     _sizeAnimation = TweenSequence<double>([
//       TweenSequenceItem<double>(
//         tween: Tween<double>(
//           begin: 50.0,
//           end: 100.0,
//         ),
//         weight: 50.0,
//       ),
//       // TweenSequenceItem<double>(
//       //   tween: Tween<double>(
//       //     begin: 100.0,
//       //     end: 75.0,
//       //   ),
//       //   weight: 50.0,
//       // ),
//     ]).animate(_controller);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: AppColors.,
//       body: SafeArea(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             bool visible = _sizeAnimation.value > 80;
//             if (visible) {
//               log(_sizeAnimation.value.toString());
//             }

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Stack(
//                 children: [
//                   Visibility(
//                     visible: !visible,
//                     child: Container(
//                       width: _sizeAnimation.value,
//                       height: _sizeAnimation.value,
//                       color: _colorAnimation.value,
//                       child: const Center(
//                         child: Text(
//                           'Animated Box',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: visible,
//                     child: const NewWidget(),
//                   ),
//                   Positioned(
//                     top: 0,
//                     child: SlideTransition(
//                       position: _slideAnimation,
//                       child: const CircleAvatar(
//                         backgroundColor: Colors.red,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     log('NewWidget');
//     return Container(
//       height: context.height,
//       width: context.width,
//       color: AppColors.yellow,
//       child: const Column(
//         children: [],
//       ),
//     );
//   }
// }
