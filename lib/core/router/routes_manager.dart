import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/features/product_details/cubit/product_details_cubit.dart';
import 'package:food_delivery/features/product_details/views/product_details_view.dart';
import 'package:food_delivery/features/splash/splash_view.dart';

import '../../features/home/views/home_view.dart';
import '../../features/onboarding/cubit/onboarding_cubit.dart';
import '../../features/onboarding/views/onboarding_home_view.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'routes_constants.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    const Interval opacityCurve = Interval(
      0.20,
      0.75,
      curve: Curves.fastOutSlowIn,
    );
    switch (settings.name) {
      case AppRoutesConstants.onboardingHomeView:
        return BlocProvider<OnboardingCubit>(
          create: (BuildContext context) => OnboardingCubit(),
          child: const OnboardingHomeView(),
        ).routeWithFadeTransition();

      case AppRoutesConstants.homeView:
        return const HomeView().routeWithFadeTransition(
          transitionDuration: 300,
        );

      case AppRoutesConstants.splashView:
        return const SplashView().routeWithFadeTransition();

      case AppRoutesConstants.productDetailsView:
        return const SizedBox().routeWithAnimatedBuilder(
          transitionDuration: 700,
          reverseTransitionDuration: 2000,
          widget: (animation) {
            return BlocProvider<ProductDetailsCubit>(
              create: (BuildContext context) => ProductDetailsCubit(),
              child: Opacity(
                opacity: opacityCurve.transform(animation.value),
                child: const ProductDetailsView(),
              ),
            );
          },
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
            ),
          ),
        ),
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
          ),
        ),
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
      transitionDuration: Duration(
        milliseconds: transitionDuration ?? 1500,
      ),
      reverseTransitionDuration: Duration(
        milliseconds: (reverseTransitionDuration ?? transitionDuration) ?? 1500,
      ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(opacity: animation, child: this);
      },
    );
  }

  PageRouteBuilder<dynamic> routeWithAnimatedBuilder({
    required Widget Function(Animation<double> animation) widget,
    int? transitionDuration,
    int? reverseTransitionDuration,
  }) {
    return PageRouteBuilder<void>(
      transitionDuration: Duration(
        milliseconds: transitionDuration ?? 2000,
      ),
      reverseTransitionDuration: Duration(
        milliseconds: reverseTransitionDuration ?? 2000,
      ),
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
