import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/food_delivery.dart';

import 'core/helpers/helper_shared_preferences.dart';
import 'core/utils/bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // Whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
  await HelperSharedPreferences().init();
  // This line for fix hide text bugs in screen_utils in release mode
  await ScreenUtil.ensureScreenSize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const FoodDeliveryApp());
}


// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

/// Flutter code sample for [Hero].

// void main() {
//   // Slow down time to see Hero flight animation.
//   timeDilation = 15.0;
//   runApp(const HeroApp());
// }

// class HeroApp extends StatelessWidget {
//   const HeroApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: const HeroExample(),
//     );
//   }
// }

// class HeroExample extends StatelessWidget {
//   const HeroExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Hero Sample')),
//       body: Column(
//         children: <Widget>[
//           ListTile(
//             leading: Hero(
//               tag: 'hero-default-tween',
//               child: BoxWidget(
//                 size: const Size(50.0, 50.0),
//                 color: Colors.red[700]!.withOpacity(0.5),
//               ),
//             ),
//             title: const Text(
//               'This red icon will use a default rect tween during the hero flight.',
//             ),
//           ),
//           const SizedBox(height: 10.0),
//           ListTile(
//             leading: Hero(
//               tag: 'hero-custom-tween',
//               createRectTween: (Rect? begin, Rect? end) {
//                 return MaterialRectCenterArcTween(begin: begin, end: end);
//               },
//               child: BoxWidget(
//                 size: const Size(50.0, 50.0),
//                 color: Colors.blue[700]!.withOpacity(0.5),
//               ),
//             ),
//             title: const Text(
//               'This blue icon will use a custom rect tween during the hero flight.',
//             ),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => _gotoDetailsPage(context),
//             child: const Text('Tap to trigger hero flight'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _gotoDetailsPage(BuildContext context) {
//     Navigator.of(context).push(MaterialPageRoute<void>(
//       builder: (BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: const Text('Second Page'),
//         ),
//         body: Align(
//           alignment: Alignment.bottomRight,
//           child: Stack(
//             children: <Widget>[
//               Hero(
//                 tag: 'hero-custom-tween',
//                 createRectTween: (Rect? begin, Rect? end) {
//                   return MaterialRectCenterArcTween(begin: begin, end: end);
//                 },
//                 child: BoxWidget(
//                   size: const Size(400.0, 400.0),
//                   color: Colors.blue[700]!.withOpacity(0.5),
//                 ),
//               ),
//               Hero(
//                 tag: 'hero-default-tween',
//                 child: BoxWidget(
//                   size: const Size(400.0, 400.0),
//                   color: Colors.red[700]!.withOpacity(0.5),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

// class BoxWidget extends StatelessWidget {
//   const BoxWidget({
//     super.key,
//     required this.size,
//     required this.color,
//   });

//   final Size size;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size.width,
//       height: size.height,
//       color: color,
//     );
//   }
// }
