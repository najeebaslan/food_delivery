import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/blocs/home_animation_cubit/home_animation_cubit.dart';

import '../../../core/constants/assets_constants.dart';
import '../../menu/menu_view.dart';
import '../../onboarding/widgets/onboarding_circle_bold_green.dart';
import 'home_view_body.dart';
import 'widgets/home_view_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late HomeAnimationCubit _homeAnimationCubit;

  @override
  void didChangeDependencies() {
    _homeAnimationCubit = BlocProvider.of<HomeAnimationCubit>(context);
    _homeAnimationCubit.animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.globalDuration,
      ),
    );
    _homeAnimationCubit.setupAnimation(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _homeAnimationCubit.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentBottomPadding: false,
      iosContentPadding: false,
      backgroundColor: AppColors.homeBackground,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const HomeViewBody(),
          const HomeViewHeader(),
          Positioned(
            top: 70.h,
            left: 24.w,
            child: Transform.rotate(
              angle: 6,
              child: SvgPicture.asset(
                ImagesConstants.ellipseRed,
                height: 32.28.h,
                width: 32.28.w,
              ),
            ),
          ),
          FadeTransition(
            opacity: _homeAnimationCubit.opacityColorMenu,
            child: BlocBuilder<HomeAnimationCubit, HomeAnimationState>(
              buildWhen: (previous, current) => current is ChangePageView,
              builder: (context, state) {
                return Visibility(
                  visible: _homeAnimationCubit.pageViewEnum == PageViewEnum.menu,
                  child: MenuView(
                    homeAnimationCubit: _homeAnimationCubit,
                  ),
                );
              },
            ),
          ),
          AnimatedBuilder(
            animation: _homeAnimationCubit.animationController,
            builder: (context, child) {
              return AnimatedPositioned(
                left: _homeAnimationCubit.positionRedCircleFat.value.width.w,
                duration: Duration.zero,
                top: _homeAnimationCubit.positionRedCircleFat.value.height.h,
                child: Transform.rotate(
                  angle: _homeAnimationCubit.rotationRedCircleFat.value,
                  child: _buildRedCircleFat(
                    size: _homeAnimationCubit.sizeRedCircleFat.value,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _homeAnimationCubit.animationController,
            builder: (context, child) {
              return AnimatedPositioned(
                top: _homeAnimationCubit.positionGreenCircle.value.height.h,
                left: _homeAnimationCubit.positionGreenCircle.value.width.w,
                duration: Duration.zero,
                child: Transform.rotate(
                  angle: _homeAnimationCubit.rotationGreenCircle.value,
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: const Offset(-2, 0),
                    child: Opacity(
                      opacity: 0.90,
                      child: OnboardingCircleGreenSmallWidget(
                        width: _homeAnimationCubit.sizeGreenCircle.value.w,
                        color: AppColors.green.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _homeAnimationCubit.animationController,
            builder: (context, child) {
              return AnimatedPositioned(
                left: _homeAnimationCubit.positionYellowCircle.value.width.w,
                top: _homeAnimationCubit.positionYellowCircle.value.height.h,
                duration: Duration.zero,
                child: Transform.rotate(
                  angle: -_homeAnimationCubit.rotationYellowCircle.value,
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    SVGStrings.yellowCircle,
                    height: _homeAnimationCubit.sizeYellowCircle.value.h,
                    width: _homeAnimationCubit.sizeYellowCircle.value.w,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Transform _buildRedCircleFat({Color? color, required double size}) {
    return Transform.rotate(
      angle: 3,
      child: Opacity(
        opacity: 0.10,
        child: SvgPicture.asset(
          ImagesConstants.ellipseRed,
          height: size.h,
          width: size.w,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                )
              : null,
        ),
      ),
    );
  }
}
