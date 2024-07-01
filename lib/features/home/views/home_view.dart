import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/features/home/blocs/home_cubit/home_cubit.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../menu/menu_view.dart';
import '../../onboarding/widgets/onboarding_circle_bold_green.dart';
import 'home_view_body.dart';
import 'widgets/header_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // Red Circle Fat
  late Animation<double> _rotationRedCircleFat;
  late Animation<Size> _positionRedCircleFat;
  late Animation<double> _sizeRedCircleFat;
  // Yellow Circle
  late Animation<double> _rotationYellowCircle;
  late Animation<Size> _positionYellowCircle;
  late Animation<double> _sizeYellowCircle;
  //  Green Circle
  late Animation<double> _rotationGreenCircle;
  late Animation<Size> _positionGreenCircle;
  late Animation<double> _sizeGreenCircle;
// List Menu Texts
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityTextAnimation;

  late final curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutBack,
  );

  void setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1350,
      ),
    );
    // Red Circle
    _rotationRedCircleFat = Tween<double>(
      begin: 0.0,
      end: 2.3,
    ).animate(curve);
    _positionRedCircleFat = Tween<Size>(
      begin: const Size(55, 57),
      end: Size(0, context.height * 0.66),
    ).animate(curve);

    _sizeRedCircleFat = Tween<double>(
      begin: 65.303,
      end: 248.46,
    ).animate(curve);
// Yellow Circle
    _rotationYellowCircle = Tween<double>(
      begin: 0.0,
      end: 2.9,
    ).animate(curve);

    _positionYellowCircle = Tween<Size>(
      begin: const Size(60, 40),
      end: Size(70, context.height * 0.87),
    ).animate(curve);

    _sizeYellowCircle = Tween<double>(
      begin: 36.308,
      end: 138.142,
    ).animate(curve);

    // Green Circle
    _rotationGreenCircle = Tween<double>(
      begin: 0.0,
      end: 5.2,
    ).animate(curve);

    _positionGreenCircle = Tween<Size>(
      begin: Size(24.w, 70),
      end: Size(context.width * 0.58, context.height * 0.81),
    ).animate(curve);

    _sizeGreenCircle = Tween<double>(
      begin: 32.25,
      end: 134.118,
    ).animate(curve);

// List Menu Texts

    _heightAnimation = Tween<double>(
      begin: 20.0.h,
      end: 300.0.h,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    _opacityTextAnimation = Tween<double>(
      begin: 0.0.h,
      end: 1.0.h,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  void startOrReverseAnimation() {
    _animationController.value == 0.0
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void didChangeDependencies() {
    setupAnimation();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is ChangeHomeBackground,
      builder: (context, state) {
        return PlatformScaffold(
          iosContentBottomPadding: false,
          iosContentPadding: false,
          backgroundColor: context.read<HomeCubit>().homeBackground,
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
              _buildOpenMenu(),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  if (shouldOpenMenu && _sizeRedCircleFat.value < 100) {
                    context.read<HomeCubit>().changeHomeBackground();
                    log('message');
                  }
                  return AnimatedPositioned(
                    left: _positionRedCircleFat.value.width.w,
                    duration: Duration.zero,
                    top: _positionRedCircleFat.value.height.h,
                    child: Transform.rotate(
                      angle: _rotationRedCircleFat.value,
                      child: _buildRedCircleFat(
                        size: _sizeRedCircleFat.value,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return AnimatedPositioned(
                    top: _positionGreenCircle.value.height.h,
                    left: _positionGreenCircle.value.width.w,
                    duration: Duration.zero,
                    child: Transform.rotate(
                      angle: _rotationGreenCircle.value,
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: const Offset(-2, 0),
                        child: Opacity(
                          opacity: 0.90,
                          child: OnboardingCircleGreenSmallWidget(
                            width: _sizeGreenCircle.value.w,
                            color: AppColors.green.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return AnimatedPositioned(
                    left: _positionYellowCircle.value.width.w,
                    top: _positionYellowCircle.value.height.h,
                    duration: Duration.zero,
                    child: Transform.rotate(
                      angle: -_rotationYellowCircle.value,
                      alignment: Alignment.center,
                      child: SvgPicture.string(
                        SVGStrings.yellowCircle,
                        height: _sizeYellowCircle.value.h,
                        width: _sizeYellowCircle.value.w,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOpenMenu() {
    const List<String> titles = [
      "Order History",
      "Offers",
      "Settings",
      "Wallet",
      "Support",
      "Logout",
    ];
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          if (shouldOpenMenu) {
            return const MenuView();
            // GestureDetector(
            //   onTap: () => startOrReverseAnimation(),
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: context.height,
            //     width: context.width,
            //     padding: EdgeInsets.symmetric(
            //       horizontal: 35.w,
            //     ),
            //     color: context.read<HomeCubit>().homeBackground,
            //     child: AnimatedBuilder(
            //       animation: _heightAnimation,
            //       builder: (context, child) {
            //         return Stack(
            //           alignment: AlignmentDirectional.centerEnd,
            //           clipBehavior: Clip.none,
            //           children: [
            //             Transform.translate(
            //               offset: const Offset(0, -100),
            //               child: PlatformAppBar(
            //                 backgroundColor: AppColors.backgroundMenuViewColor,
            //                 material: (context, platform) => MaterialAppBarData(
            //                   automaticallyImplyLeading: false,
            //                 ),
            //                 cupertino: (context, platform) {
            //                   return CupertinoNavigationBarData(
            //                     noMaterialParent: false,
            //                     brightness: Brightness.light,
            //                     automaticallyImplyMiddle: false,
            //                     border: const Border.fromBorderSide(BorderSide.none),
            //                     backgroundColor: Colors.transparent,
            //                     transitionBetweenRoutes: false,
            //                     automaticallyImplyLeading: false,
            //                   );
            //                 },
            //                 title: Align(
            //                   alignment: AlignmentDirectional.centerEnd,
            //                   child: Padding(
            //                     padding: EdgeInsets.only(
            //                       right: context.isIOS ? 24.w : 5.w,
            //                     ),
            //                     child: PlatformIconButton(
            //                       // onPressed: () => backToHomeView(context),
            //                       padding: EdgeInsets.zero,
            //                       icon: Icon(
            //                         Icons.close,
            //                         color: AppColors.black,
            //                         size: 25,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               alignment: Alignment.center,
            //               height: _heightAnimation.value < 0 ? 0 : _heightAnimation.value,
            //               width: 200.0.w,
            //             ),
            //             ...List.generate(
            //               titles.length,
            //               (index) {
            //                 return Positioned(
            //                   top: (_heightAnimation.value / titles.length) * index,
            //                   child: Opacity(
            //                     opacity: textOpacity,
            //                     child: Text(
            //                       titles[index],
            //                       textAlign: TextAlign.right,
            //                       style: AppTextStyles.font30Black700W,
            //                     ),
            //                   ),
            //                 );
            //               },
            //             )
            //           ],
            //         );
            //       },
            //     ),
            //   ),
            // );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    });
  }

  bool get shouldOpenMenu => _sizeRedCircleFat.value > 100;

  double get textOpacity {
    if (_opacityTextAnimation.value < 0) return 0;
    return _opacityTextAnimation.value > 1 ? 1 : _opacityTextAnimation.value;
  }

  BlocBuilder _buildHeader() {
    return BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is ChangeHomeBackground,
        builder: (context, state) {
          return Overlay(
            clipBehavior: Clip.none,
            initialEntries: [
              OverlayEntry(
                builder: (context) {
                  return Positioned(
                    top: (kToolbarHeight * 2).h,
                    width: context.width,
                    child: ColoredBox(
                      color: context.read<HomeCubit>().homeBackground,
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
                      color: context.read<HomeCubit>().homeBackground,
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
        });
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
        startOrReverseAnimation();
        // context.read<HomeCubit>().navigateToView(
        //       NavigateTo.menu,
        //     );

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
