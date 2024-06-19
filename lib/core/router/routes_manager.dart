import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/widget/splash_animation/splash_animation_view.dart';

import '../../features/home/views/home_view.dart';
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
            )).withAnimation();

      case AppRoutesConstants.splashView:
        return const SplashAnimationView().withAnimation();
      case AppRoutesConstants.homeView:
        return const HomeView().withAnimation(milliseconds: 200);

      default:
        return unknownRouteScreen();
    }
  }

  static Route<dynamic> unknownRouteScreen() {
    return MaterialPageRoute(
      builder: (_) => PlatformScaffold(
        appBar: PlatformAppBar(
            title: Text(
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
            child: Text(
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
  PageRouteBuilder<dynamic> withAnimation({int? milliseconds}) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: milliseconds ?? 1500),
      reverseTransitionDuration: Duration(milliseconds: milliseconds ?? 1500),
      pageBuilder: (context, animation, secondaryAnimation) =>
          FadeTransition(opacity: animation, child: this),
    );
  }
}
