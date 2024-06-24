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
              // home: const ExpandingContainer(),
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





class ExpandingContainer extends StatefulWidget {
  final Widget child;
  final bool isOpen;
  final Duration duration;

  const ExpandingContainer({
    required this.child,
    required this.isOpen,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  _ExpandingContainerState createState() => _ExpandingContainerState();
}

class _ExpandingContainerState extends State<ExpandingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    if (widget.isOpen) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant ExpandingContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => ClipRect(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
                // Adjust height based on your content
                height: _heightAnimation.value * MediaQuery.of(context).size.height,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
