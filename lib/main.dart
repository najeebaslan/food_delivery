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

// /// Flutter code sample for [Overlay].

// void main() => runApp(const OverlayApp());

// class OverlayApp extends StatelessWidget {
//   const OverlayApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: OverlayExample(),
//     );
//   }
// }

// class OverlayExample extends StatefulWidget {
//   const OverlayExample({super.key});

//   @override
//   State<OverlayExample> createState() => _OverlayExampleState();
// }

// class _OverlayExampleState extends State<OverlayExample> {
//   OverlayEntry? overlayEntry;
//   int currentPageIndex = 0;

//   void createHighlightOverlay({
//     required AlignmentDirectional alignment,
//     required Color borderColor,
//   }) {
//     // Remove the existing OverlayEntry.
//     removeHighlightOverlay();

//     assert(overlayEntry == null);

//     overlayEntry = OverlayEntry(
//       // Create a new OverlayEntry.
//       builder: (BuildContext context) {
//         // Align is used to position the highlight overlay
//         // relative to the NavigationBar destination.
//         return SafeArea(
//           child: Align(
//             alignment: alignment,
//             heightFactor: 1.0,
//             child: DefaultTextStyle(
//               style: const TextStyle(
//                 color: Colors.blue,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.0,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const Text('Tap here for'),
//                   Builder(builder: (BuildContext context) {
//                     switch (currentPageIndex) {
//                       case 0:
//                         return const Column(
//                           children: <Widget>[
//                             Text(
//                               'Explore page',
//                               style: TextStyle(
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_downward,
//                               color: Colors.red,
//                             ),
//                           ],
//                         );
//                       case 1:
//                         return const Column(
//                           children: <Widget>[
//                             Text(
//                               'Commute page',
//                               style: TextStyle(
//                                 color: Colors.green,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_downward,
//                               color: Colors.green,
//                             ),
//                           ],
//                         );
//                       case 2:
//                         return const Column(
//                           children: <Widget>[
//                             Text(
//                               'Saved page',
//                               style: TextStyle(
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             Icon(
//                               Icons.arrow_downward,
//                               color: Colors.orange,
//                             ),
//                           ],
//                         );
//                       default:
//                         return const Text('No page selected.');
//                     }
//                   }),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 3,
//                     height: 80.0,
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: borderColor,
//                             width: 4.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );

//     // Add the OverlayEntry to the Overlay.
//     Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
//   }

//   // Remove the OverlayEntry.
//   void removeHighlightOverlay() {
//     overlayEntry?.remove();
//     overlayEntry?.dispose();
//     overlayEntry = null;
//   }

//   @override
//   void dispose() {
//     // Make sure to remove OverlayEntry when the widget is disposed.
//     removeHighlightOverlay();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Overlay Sample'),
//       ),
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: currentPageIndex,
//         destinations: const <NavigationDestination>[
//           NavigationDestination(
//             icon: Icon(Icons.explore),
//             label: 'Explore',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.commute),
//             label: 'Commute',
//           ),
//           NavigationDestination(
//             selectedIcon: Icon(Icons.bookmark),
//             icon: Icon(Icons.bookmark_border),
//             label: 'Saved',
//           ),
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Use Overlay to highlight a NavigationBar destination',
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           const SizedBox(height: 20.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // This creates a highlight Overlay for
//               // the Explore item.
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     currentPageIndex = 0;
//                   });
//                   createHighlightOverlay(
//                     alignment: AlignmentDirectional.bottomStart,
//                     borderColor: Colors.red,
//                   );
//                 },
//                 child: const Text('Explore'),
//               ),
//               const SizedBox(width: 20.0),
//               // This creates a highlight Overlay for
//               // the Commute item.
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     currentPageIndex = 1;
//                   });
//                   createHighlightOverlay(
//                     alignment: AlignmentDirectional.bottomCenter,
//                     borderColor: Colors.green,
//                   );
//                 },
//                 child: const Text('Commute'),
//               ),
//               const SizedBox(width: 20.0),
//               // This creates a highlight Overlay for
//               // the Saved item.
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     currentPageIndex = 2;
//                   });
//                   createHighlightOverlay(
//                     alignment: AlignmentDirectional.bottomEnd,
//                     borderColor: Colors.orange,
//                   );
//                 },
//                 child: const Text('Saved'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10.0),
//           ElevatedButton(
//             onPressed: () {
//               removeHighlightOverlay();
//             },
//             child: const Text('Remove Overlay'),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// /// Flutter code sample for [OverlayPortal].

// void main() => runApp(const OverlayPortalExampleApp());

// class OverlayPortalExampleApp extends StatelessWidget {
//   const OverlayPortalExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('OverlayPortal Example')),
//         body: const Center(child: ClickableTooltipWidget()),
//       ),
//     );
//   }
// }

// class ClickableTooltipWidget extends StatefulWidget {
//   const ClickableTooltipWidget({super.key});

//   @override
//   State<StatefulWidget> createState() => ClickableTooltipWidgetState();
// }

// class ClickableTooltipWidgetState extends State<ClickableTooltipWidget> {
//   final OverlayPortalController _tooltipController = OverlayPortalController();

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: _tooltipController.toggle,
//       child: DefaultTextStyle(
//         style: DefaultTextStyle.of(context).style.copyWith(fontSize: 50),
//         child: OverlayPortal(
//           controller: _tooltipController,
//           overlayChildBuilder: (BuildContext context) {
//             return const Positioned(
//               right: 50,
//               bottom: 50,
//               top: 0,
//               child: ColoredBox(
//                 color: Colors.amberAccent,
//                 child: Text('tooltip'),
//               ),
//             );
//           },
//           child: const Text('Press to show/hide tooltip'),
//         ),
//       ),
//     );
//   }
// }
