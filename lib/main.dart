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

// // Copyright 2019 the Dart project authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license
// // that can be found in the LICENSE file.

// import 'package:flutter/material.dart';

// const owlUrl =
//     'https://raw.githubusercontent.com/flutter/website/main/src/content/assets/images/docs/owl.jpg';

// class FadeInDemo extends StatefulWidget {
//   const FadeInDemo({super.key});

//   @override
//   State<FadeInDemo> createState() => _FadeInDemoState();
// }

// class _FadeInDemoState extends State<FadeInDemo> {
//   double opacity = 0;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(children: <Widget>[
//       Image.network(owlUrl),
//       TextButton(
//         child: const Text(
//           'Show Details',
//           style: TextStyle(color: Colors.blueAccent),
//         ),
//         onPressed: () => {opacity = 1, setState(() {})},
//       ),
//       AnimatedOpacity(
//         duration: const Duration(seconds: 1),
//         opacity: opacity,
//         child: const Column(
//           children: [
//             Text('Type: Owl'),
//             Text('Age: 39'),
//             Text('Employment: None'),
//           ],
//         ),
//       )
//     ]);
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: FadeInDemo(),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(
//     const MyApp(),
//   );
// }
