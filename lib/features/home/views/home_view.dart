import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/constants/num_constants.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/blocs/home_animation_cubit/home_animation_cubit.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../onboarding/widgets/onboarding_circle_bold_green.dart';
import 'home_view_body.dart';
import 'widgets/header_text_field.dart';

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
          _buildHeader(),
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
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Visibility(
                      visible: _homeAnimationCubit.pageViewEnum == PageViewEnum.menu,
                      child: NewWidget(
                        homeAnimationCubit: _homeAnimationCubit,
                      ),
                    );
                  },
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

  Overlay _buildHeader() {
    return Overlay(
      clipBehavior: Clip.none,
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return Positioned(
              top: (kToolbarHeight * 2).h,
              width: context.width,
              child: ColoredBox(
                color: AppColors.homeBackground,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Gap(10.h),
                      const HeaderTextField(),
                      Gap(10.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        OverlayEntry(
          builder: (context) {
            return Positioned(
              top: 0,
              width: context.width,
              child: ColoredBox(
                color: AppColors.homeBackground,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Gap(
                        context.isSmallDevice
                            ? (kToolbarHeight / 1.8).h
                            : kToolbarHeight.h,
                      ),
                      _buildAppBar(),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        SizedBox(
          width: 65.30.w,
          height: 65.30.h,
        ),
        Transform.translate(
          offset: Offset(-16.w, 1.h),
          child: _goodMorningTitle(),
        ),
        const Spacer(),
        _menuIconButton(context),
      ],
    );
  }

  Transform _buildRedCircleFat({
    Color? color,
    required double size,
  }) {
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

  Widget _goodMorningTitle() {
    return Text.rich(
      textAlign: TextAlign.left,
      TextSpan(
        children: [
          TextSpan(
            text: 'Good morning, ',
            style: AppTextStyles.font16Black300W.copyWith(
              height: 0,
            ),
          ),
          TextSpan(
            text: 'Jeev jobs',
            style: AppTextStyles.font16Black400W,
          ),
        ],
      ),
    );
  }

  PlatformIconButton _menuIconButton(
    BuildContext context,
  ) {
    return PlatformIconButton(
      onPressed: () {
        _homeAnimationCubit.startOrReverseAnimation();
        context.read<HomeAnimationCubit>().changePageView(
              PageViewEnum.menu,
            );

        // Navigator.pushNamed(
        //   context,
        //   AppRoutesConstants.menuView,
        // );
      },
      icon: SvgPicture.asset(
        ImagesConstants.homeMenuIcon,
        height: 14.h,
        width: 24.w,
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required HomeAnimationCubit homeAnimationCubit,
  }) : _homeAnimationCubit = homeAnimationCubit;

  final HomeAnimationCubit _homeAnimationCubit;

  @override
  Widget build(BuildContext context) {
    log('rebuild NewWidget');
    const List<String> titles = [
      "Order History",
      "Offers",
      "Settings",
      "Wallet",
      "Support",
      "Logout",
    ];
    return AnimatedBuilder(
      animation: _homeAnimationCubit.animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            _homeAnimationCubit.startOrReverseAnimation();
          },
          child: Container(
            alignment: Alignment.center,
            height: context.height,
            width: context.width,
            padding: EdgeInsets.symmetric(
              horizontal: 35.w,
            ),
            color: AppColors.backgroundMenuViewColor,
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: context.isIOS ? 24.w : 5.w,
                    ),
                    child: PlatformIconButton(
                      onPressed: () => _homeAnimationCubit.startOrReverseAnimation(),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.close,
                        color: AppColors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                // Transform.translate(
                //   offset: Offset(
                //       constraints.maxWidth / 11, -(constraints.maxHeight / 2.3).h),
                //   child: PlatformAppBar(
                //     backgroundColor: AppColors.backgroundMenuViewColor,
                //     material: (context, platform) {
                //       return MaterialAppBarData(
                //         automaticallyImplyLeading: false,
                //       );
                //     },
                //     cupertino: (context, platform) {
                //       return CupertinoNavigationBarData(
                //         noMaterialParent: false,
                //         brightness: Brightness.light,
                //         automaticallyImplyMiddle: false,
                //         border: const Border.fromBorderSide(BorderSide.none),
                //         backgroundColor: Colors.transparent,
                //         transitionBetweenRoutes: false,
                //         automaticallyImplyLeading: false,
                //       );
                //     },
                //     title: Align(
                //       alignment: AlignmentDirectional.centerEnd,
                //       child: Padding(
                //         padding: EdgeInsets.only(
                //           right: context.isIOS ? 24.w : 5.w,
                //         ),
                //         child: PlatformIconButton(
                //           // onPressed: () => backToHomeView(context),
                //           padding: EdgeInsets.zero,
                //           icon: Icon(
                //             Icons.close,
                //             color: AppColors.black,
                //             size: 25,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  // alignment: Alignment.topCenter,
                  height: _homeAnimationCubit.heightAnimation.value < 0
                      ? 0
                      : _homeAnimationCubit.heightAnimation.value,
                  width: 200.0.w,
                ),
                ...List.generate(
                  titles.length,
                  (index) {
                    return Positioned(
                      top: (_homeAnimationCubit.heightAnimation.value / titles.length) *
                          index,
                      child: Text(
                        titles[index],
                        textAlign: TextAlign.right,
                        style: AppTextStyles.font30Black700W,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
