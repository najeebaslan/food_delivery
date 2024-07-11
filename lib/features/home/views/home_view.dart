import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/blocs/home_animation_cubit/home_animation_cubit.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/constants/hero_tags_constants.dart';
import '../../../core/widget/custom_rect_tween.dart';
import '../../menu/menu_view.dart';
import 'widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import 'widgets/base_circles/hero_small_red_circle_app_bar_home_view.dart';
import 'widgets/home_view_body.dart';
import 'widgets/home_view_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late HomeAnimationCubit _homeAnimationCubit;

  @override
  void didChangeDependencies() {
    _homeAnimationCubit = BlocProvider.of<HomeAnimationCubit>(context);
    _homeAnimationCubit.menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration1350,
      ),
    );
    _homeAnimationCubit.productDetailsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: NumConstants.duration450,
      ),
      reverseDuration: const Duration(
        milliseconds: NumConstants.duration1350,
      ),
    );
    _homeAnimationCubit.setupMenuAnimations(context);
    _homeAnimationCubit.setupProductDetailsAnimations(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _homeAnimationCubit.menuAnimationController.dispose();
    _homeAnimationCubit.productDetailsAnimationController.dispose();
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
          // Red Circle Bold
          Positioned(
            top: context.mediaQueryOf.padding.top.h + 5.h,
            left: 22.w,
            child: HeroSmallRedCircleAppBarHomeView(
              height: 32.28.h,
              width: 32.28.w,
              angle: 6,
            ),
          ),
          // Menu View
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

          // Red Circle Fat
          AnimatedBuilder(
            animation: Listenable.merge([
              _homeAnimationCubit.menuAnimationController,
              _homeAnimationCubit.productDetailsAnimationController,
            ]),
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

          // Green Small Circle
          AnimatedBuilder(
            animation: Listenable.merge([
              _homeAnimationCubit.menuAnimationController,
              _homeAnimationCubit.productDetailsAnimationController,
            ]),
            builder: (context, child) {
              return AnimatedPositioned(
                top: _homeAnimationCubit.positionGreenCircle.value.height.h,
                left: _homeAnimationCubit.positionGreenCircle.value.width.w,
                duration: Duration.zero,
                child: Transform.rotate(
                  angle: _homeAnimationCubit.rotationGreenCircle.value,
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.90,
                    child: SvgPicture.asset(
                      ImagesConstants.greenCircle,
                      width: _homeAnimationCubit.sizeGreenCircle.value.width.w,
                      height: _homeAnimationCubit.sizeGreenCircle.value.height.h,
                    ),
                  ),
                ),
              );
            },
          ),

          // Yellow Circle
          AnimatedBuilder(
            animation: Listenable.merge([
              _homeAnimationCubit.menuAnimationController,
              _homeAnimationCubit.productDetailsAnimationController,
            ]),
            builder: (context, child) {
              return AnimatedPositioned(
                left: _homeAnimationCubit.positionYellowCircle.value.width.w,
                top: _homeAnimationCubit.positionYellowCircle.value.height.h,
                duration: Duration.zero,
                child: Transform.rotate(
                    angle: -_homeAnimationCubit.rotationYellowCircle.value,
                    alignment: Alignment.center,
                    child: Hero(
                      tag: HeroTagsConstants.circleYellowTagHomeViewAppBar,
                      createRectTween: (begin, end) {
                        return CustomRectTween(begin: begin!, end: end!);
                      },
                      child: SvgPicture.string(
                        SVGImageConstants.yellowCircle,
                        height: _homeAnimationCubit.sizeYellowCircle.value.h,
                        width: _homeAnimationCubit.sizeYellowCircle.value.w,
                      ),
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  HeroRedCircleAppBarHomeView _buildRedCircleFat({required double size}) {
    return HeroRedCircleAppBarHomeView(
      parameters: HeroRedCircleParameters(
        height: size.h,
        width: size.h,
        animatedBuilderChildAngle: (animationValue) {
          return animationValue > 1 ? 4 : 3;
        },
      ),
    );
  }
}
