import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/cubit/home_animation_cubit.dart';

import 'core/router/routes_constants.dart';
import 'core/router/routes_manager.dart';
import 'features/home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import 'features/product_details/views/widgets/base_circles/hero_blue_circle_product.dart';

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
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<HomeAnimationCubit>(
          create: (BuildContext context) => HomeAnimationCubit(),
          child: PlatformApp(
            onGenerateRoute: AppRouter.onGenerateRoute,
            // initialRoute: AppRoutesConstants.splashView,
            initialRoute: AppRoutesConstants.homeView,
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
                // home: const MyApp(),
                // const RotatingCircle(
                //   color: Colors.red,
                //   size: 200,
                // ),
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
                  useMaterial3: true,
                  brightness: Brightness.light,
                  appBarTheme: const AppBarTheme(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  primaryColor: AppColors.kPrimaryColor,
                  scaffoldBackgroundColor: AppColors.background,
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
                themeMode: ThemeMode.light,
              );
            },
          ),
        );
      },
    );
  }
}

class RotatingCircle extends StatefulWidget {
  final double size;
  final Color color;

  const RotatingCircle({super.key, required this.size, required this.color});

  @override
  State<RotatingCircle> createState() => _RotatingCircleState();
}

class _RotatingCircleState extends State<RotatingCircle> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _rotationAnimation;

  final Map<CircleSizeTransition, Tween<double>> _rotationTweens = {
    CircleSizeTransition.LargeToSmall: Tween<double>(begin: -2.1, end: -1.3),
    CircleSizeTransition.LargeToMedium: Tween<double>(begin: 0.0, end: -1.3),
    CircleSizeTransition.SmallToMedium: Tween<double>(begin: -2.1, end: 0.0),
    CircleSizeTransition.MediumToLarge: Tween<double>(begin: 0.0, end: -1.3),
    CircleSizeTransition.MediumToSmall: Tween<double>(begin: 0.0, end: -2.1),
    CircleSizeTransition.SmallToLarge: Tween<double>(begin: -1.3, end: -2.1),
  };

  final Curve _adaptiveCurve = Curves.easeInOut; // Adjust curve as needed

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationAnimation = Tween(
      begin: 0.0,
      end: 2 * 3.14159,
    ).animate(_controller);

    // _rotateTo(CircleSizeTransition.MediumToSmall);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _currentRotation = 0.0; // Track current rotation

  void _rotateTo(CircleSizeTransition transition) async {
    final rotationTween = _rotationTweens[transition];
    if (rotationTween != null) {
      // final targetRotation = rotationTween.end!.value + _currentRotation;
      final targetRotation = rotationTween.end! + _currentRotation;

      _rotationAnimation = Tween<double>(begin: _currentRotation, end: targetRotation)
          .animate(_controller);
      await _controller.forward();
      _currentRotation = targetRotation; // Update current rotation
      _controller.reset(); // Reset for future animations
    } else {
      print('Unsupported transition: $transition'); // Handle unsupported cases
    }
  }

  // void _rotateTo(CircleSizeTransition transition) async {
  //   final rotationTween = _rotationTweens[transition];
  //   if (rotationTween != null) {
  //     _rotationAnimation = rotationTween.animate(_controller);
  //     await _controller.forward();
  //     _controller.reset(); // Reset for future animations
  //   } else {
  //     print('Unsupported transition: $transition'); // Handle unsupported cases
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (_, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(_rotationAnimation.value),
              child: HeroBlueCircleProduct(
                parameters: HeroRedCircleParameters(
                  showProductDetails: true,
                  width: 195.02.w,
                  height: 195.02.h,
                  angle: 4,
                  color: AppColors.blue.withOpacity(0.9
                      // _productCubit.getOldAndCurrentSize ==
                      //         (
                      //           ProductDetailsSizeEnum.medium,
                      //           ProductDetailsSizeEnum.medium,
                      //         )
                      //     ? 1.0
                      //     : colorOpacity ?? blueCircleOpacity.value.clamp(0.0, 1.0),
                      ),
                  animatedBuilderChildAngle: (animationValue) {
                    return animationValue > 1 ? 4 : 3;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0), // Add spacing between buttons and circle
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _rotateTo(CircleSizeTransition.LargeToSmall),
                  child: const Text('Large To Small'),
                ),
                ElevatedButton(
                  onPressed: () => _rotateTo(CircleSizeTransition.LargeToMedium),
                  child: const Text('Large To Medium'),
                ),
                ElevatedButton(
                  onPressed: () => _rotateTo(CircleSizeTransition.SmallToMedium),
                  child: const Text('Small To Medium'),
                ),
                ElevatedButton(
                  onPressed: () => _rotateTo(CircleSizeTransition.MediumToLarge),
                  child: const Text('Medium To Large'),
                ),
                ElevatedButton(
                  onPressed: () => _rotateTo(CircleSizeTransition.MediumToSmall),
                  child: const Text('Medium To Small'),
                ),
                ElevatedButton(
                  onPressed: () => _rotateTo(CircleSizeTransition.SmallToLarge),
                  child: const Text('Small To Large'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum CircleSizeTransition {
  LargeToSmall,
  LargeToMedium,
  SmallToMedium,
  MediumToLarge,
  MediumToSmall,
  SmallToLarge,
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  // Define your 10 rotation values
  final List<double> _rotationValues = [
    0,
    0.5 * 3.14159,
    4.5 * 3.14159,
    3.5 * 3.14159,
    1 * 3.14159,
    2.5 * 3.14159,
    4 * 3.14159,
    1.5 * 3.14159,
    3 * 3.14159,
    2 * 3.14159,
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: _rotationValues[0],
      end: _rotationValues[1],
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rotating Widget'),
        ),
        body: Center(
          child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: HeroBlueCircleProduct(
                        parameters: HeroRedCircleParameters(
                          showProductDetails: true,
                          width: 195.02.w,
                          height: 195.02.h,
                          angle: 4,
                          color: AppColors.blue.withOpacity(0.9
                              // _productCubit.getOldAndCurrentSize ==
                              //         (
                              //           ProductDetailsSizeEnum.medium,
                              //           ProductDetailsSizeEnum.medium,
                              //         )
                              //     ? 1.0
                              //     : colorOpacity ?? blueCircleOpacity.value.clamp(0.0, 1.0),
                              ),
                          animatedBuilderChildAngle: (animationValue) {
                            return animationValue > 1 ? 4 : 3;
                          },
                        ),
                      ),
                    ),
                    Text(_currentIndex.toString()),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _currentIndex = (_currentIndex + 1) % _rotationValues.length;
            _rotationAnimation = Tween<double>(
              begin: _rotationValues[_currentIndex],
              end: _rotationValues[(_currentIndex + 1) % _rotationValues.length],
            ).animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInBack,
            ));
            _animationController.reset();
            _animationController.forward();
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
