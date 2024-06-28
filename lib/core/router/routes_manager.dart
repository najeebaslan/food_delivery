import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/widget/splash_animation/splash_animation_view.dart';
import 'package:food_delivery/features/home/blocs/home_cubit/home_cubit.dart';

import '../../features/home/views/home_view.dart';
import '../../features/home/views/menu_view.dart';
import '../../features/onboarding/onboarding_cubit/onboarding_cubit.dart';
import '../../features/onboarding/onboarding_home_view.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'routes_constants.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // --------------- Auth Screen ---------------//
      case AppRoutesConstants.onboardingHomeView:
        return BlocProvider<OnboardingCubit>(
          create: (BuildContext context) => OnboardingCubit(),
          child: OnboardingHomeView(
            onboardingHeroTags: settings.arguments as OnboardingHeroTags,
          ),
        ).routeWithFadeTransition();

      case AppRoutesConstants.homeView:
        return BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
          child: HomeView(
            redCircleTag: (settings.arguments as String?) ?? 'drinkTag',
          ),
        ).routeWithFadeTransition(transitionDuration: 300);

      case AppRoutesConstants.splashView:
        return const SplashAnimationView().routeWithFadeTransition();

      case AppRoutesConstants.menuView:
        return const MenuView().routeWithFadeTransition(
          transitionDuration: 1350,
          reverseTransitionDuration: 1350,
        );
      default:
        return unknownRouteScreen();
    }
  }

  static Route<dynamic> unknownRouteScreen() {
    return MaterialPageRoute(
      builder: (_) => PlatformScaffold(
        appBar: PlatformAppBar(
            title: PlatformText(
          'مسار غير معروف',
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.black.withOpacity(0.7),
            fontFamily: AppTextStyles.defaultFontFamily,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.ellipsis,
            //
          ),
        )),
        body: Center(
            child: PlatformText(
          'من فضلك تاكد من صحة المسار الذي تريد الذهاب إليه',
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.black,
            fontFamily: AppTextStyles.defaultFontFamily,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        )),
      ),
    );
  }
}

extension AnimationPageRouter on Widget {
  PageRouteBuilder<dynamic> routeWithFadeTransition({
    int? transitionDuration,
    int? reverseTransitionDuration,
  }) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      transitionDuration: Duration(milliseconds: transitionDuration ?? 1500),
      reverseTransitionDuration: Duration(
          milliseconds: (reverseTransitionDuration ?? transitionDuration) ?? 1500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(opacity: animation, child: this);
      },
    );
  }

  PageRouteBuilder<dynamic> routeWithAnimatedBuilder(
      Widget Function(Animation<double> animation) widget) {
    return PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 2000),
      reverseTransitionDuration: const Duration(milliseconds: 2000),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return widget(animation);
          },
        );
      },
    );
  }
}
