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

// import 'package:flutter/material.dart';

// import 'core/styles/app_colors.dart';
// import 'core/styles/app_text_styles.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Animated Container Demo',
//       home: AnimatedContainerPage(),
//     );
//   }
// }

// class AnimatedContainerPage extends StatefulWidget {
//   const AnimatedContainerPage({super.key});

//   @override
//   _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
// }

// class _AnimatedContainerPageState extends State<AnimatedContainerPage>
//     with SingleTickerProviderStateMixin {
//   bool _isExpanded = false;
//   late AnimationController _animationController;
//   late Animation<double> _heightAnimation;
//   static const List<String> titles = [
//     "Order History",
//     "Offers",
//     "Settings",
//     "Wallet",
//     "Support",
//     "Logout",
//   ];
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );

//     _heightAnimation = Tween<double>(
//       begin: 100.0,
//       end: 400.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOutBack,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Animated Container Demo'),
//       ),
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _heightAnimation,
//           builder: (context, child) {
//             return Stack(
//               alignment: Alignment.center,
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   height: _heightAnimation.value,
//                   width: 200.0,
//                   color: Colors.blue,
//                 ),
//                 ...List.generate(
//                   titles.length,
//                   (index) {
//                     return Positioned(
//                       top: ((_heightAnimation.value / titles.length) * index),
//                       child: Text(
//                         titles[index],
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                           fontSize: 30,
//                           color: AppColors.black,
//                           fontFamily: AppTextStyles.defaultFontFamily,
//                           fontWeight: FontWeight.w700,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _isExpanded = !_isExpanded;
//             if (_isExpanded) {
//               _animationController.forward();
//             } else {
//               _animationController.reverse();
//             }
//           });
//         },
//         child: const Icon(Icons.expand),
//       ),
//     );
//   }
// }
