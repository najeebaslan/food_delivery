import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/blocs/home_cubit/home_cubit.dart';
import 'package:gap/gap.dart';

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
              // home: const MyPage(),
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

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  late HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: ValueListenableBuilder(
        valueListenable: BlocProvider.of<HomeCubit>(context).animationTransition,
        builder: (context, value, child) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroSlideTransition(
                          startScreen: const MyPage(),
                          endScreen: MyPage1(
                            homeCubit: homeCubit,
                          ),
                          homeCubit: homeCubit,
                          heroTag: "hero-animation",
                        ),
                      );

                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     transitionDuration: const Duration(seconds: 1),
                      //     reverseTransitionDuration: const Duration(seconds: 1),
                      //     transitionsBuilder: (
                      //       BuildContext context,
                      //       Animation<double> animation,
                      //       Animation<double> secAnimation,
                      //       Widget child,
                      //     ) {
                      //       animation = CurvedAnimation(
                      //         parent: animation,
                      //         curve: Curves.easeInOutBack,
                      //       );
                      //       return ScaleTransition(
                      //         scale: animation,
                      //         alignment: Alignment.center,
                      //         child: child,
                      //       );
                      //     },
                      //     pageBuilder: (
                      //       BuildContext context,
                      //       Animation<double> animation,
                      //       Animation<double> secAnimation,
                      //     ) {
                      //       return const MyPage1();
                      //     },
                      //   ),
                      // );
                      // Navigator.of(context).push(
                      //   withAnimation(),
                      //   // MaterialPageRoute(
                      //   //   builder: (context) => const MyPage1(),
                      //   // ),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // PageRouteBuilder<dynamic> withAnimation({int? milliseconds}) {
  //   return PageRouteBuilder(
  //     // transitionDuration: Duration(milliseconds: milliseconds ?? 1500),
  //     // reverseTransitionDuration: Duration(milliseconds: milliseconds ?? 1500),
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         FadeTransition(opacity: animation, child: const MyPage1()),
  //   );
  // }
}

class MyPage1 extends StatefulWidget {
  const MyPage1({super.key, required this.homeCubit});
  final HomeCubit homeCubit;
  @override
  State<MyPage1> createState() => _MyPage1State();
}

class _MyPage1State extends State<MyPage1> {
  Color backgroundColor = Colors.white;
  void changeBackgroundColor() {
    backgroundColor = Colors.red.shade100;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.homeCubit.animationTransition,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: Colors.red.shade100.withOpacity(
              widget.homeCubit.animationTransition.value,
            ),
            body: Center(
              child: Column(
                children: [
                  const Gap(100),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const Text('najeeb aslan '),
                  const Gap(100),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('start'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  bool isStarted = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1.5),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(100),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 100,
                    width: 100,
                  ),
                );
              },
            ),
            const Gap(100),
            ElevatedButton(
              onPressed: () {
                if (isStarted) {
                  _animationController.reverse();
                  isStarted = false;
                } else {
                  _animationController.forward();
                  isStarted = true;
                }

                // _animationController.addStatusListener((status) {
                //   if (status == AnimationStatus.completed) {
                //     _animationController.reverse();
                //   } else if (status == AnimationStatus.dismissed) {
                //     _animationController.forward();
                //   }
                // });
              },
              child: const Text('start'),
            )
          ],
        ),
      ),
    );
  }
}

class HeroSlideTransition extends PageRouteBuilder<void> {
  final Widget startScreen;
  final Widget endScreen;
  final String heroTag;
  final HomeCubit homeCubit;
  HeroSlideTransition({
    required this.startScreen,
    required this.endScreen,
    required this.heroTag,
    required this.homeCubit,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return endScreen;
          },
          reverseTransitionDuration: const Duration(seconds: 2),
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return ColoredBox(
              color: Colors.green,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutBack,
                  ),
                ),
                child: startScreen,
              ),
            );
          },
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    homeCubit.animationTransition.value = animation.value;
    return ColoredBox(
      color: Colors.red.shade100.withOpacity(homeCubit.animationTransition.value),
      child: Stack(
        children: [
          Hero(
            tag: heroTag,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.35),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutBack,
                ),
              ),
              child: endScreen,
            ),
          ),
        ],
      ),
    );
  }
}
