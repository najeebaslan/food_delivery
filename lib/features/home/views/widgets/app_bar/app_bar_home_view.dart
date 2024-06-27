import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/styles/app_text_styles.dart';
import '../../menu_view.dart';
import 'hero_circle_green_app_bar_home_view.dart';
import 'hero_circle_red_app_bar_home_view.dart';
import 'hero_circle_yellow_app_bar_home_view.dart';

class AppBarHomeView extends StatelessWidget {
  const AppBarHomeView({super.key, required this.redCircleTag});

  final String redCircleTag;

  @override
  Widget build(BuildContext context) {
    timeDilation = 4.0;

    return Row(
      children: [
        _heroRedAndGreenCircles(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -10.h,
              child: const HeroCircleYellowAppBarHomeView(),
            ),
            const HeroCircleRedAppBarHomeView(),
          ],
        ),
        _goodMorningTitle(),
        const Spacer(),
        _menuIconButton(context),
      ],
    );
  }

  PlatformIconButton _menuIconButton(BuildContext context) {
    return PlatformIconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return const MenuView();
            },
            fullscreenDialog: true,
          ),
        );
      },
      icon: SvgPicture.asset(
        ImagesConstants.homeMenuIcon,
        height: 14.h,
        width: 24.w,
      ),
    );
  }

  Transform _goodMorningTitle() {
    return Transform.translate(
      offset: Offset(-43.w, 0),
      child: Text.rich(
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
      ),
    );
  }

  Stack _heroRedAndGreenCircles() {
    return Stack(
      children: [
        Hero(
          tag: redCircleTag,
          child: Transform.rotate(
            angle: 6,
            child: SvgPicture.asset(
              ImagesConstants.ellipseRed,
              height: 32.28.h,
              width: 32.28.w,
            ),
          ),
        ),
        const HeroCircleGreenAppBarHomeView(),
      ],
    );
  }
}

class TestAnimations extends StatefulWidget {
  const TestAnimations({super.key});

  @override
  State<TestAnimations> createState() => _TestAnimationsState();
}

class _TestAnimationsState extends State<TestAnimations>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'tag',
              child: Container(
                height: 100,
                width: 300,
                color: Colors.blue,
              ),
            ),
            // PhotoHero(
            //   photo:
            //       'https://www.emanprague.com/en/wp-content/uploads/2018/05/flutter_eman_blog.png',
            //   fit: BoxFit.contain,
            //   onTap: () {},
            // ),
            // AnimatedBuilder(
            //   animation: _animationController,
            //   builder: (context, child) {
            //     log(_animation.value.toString());
            //     return Container(
            //       height: _animation.value,
            //       width: _animation.value,
            //       color: Colors.red,
            //     );
            //   },
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       _animationController.forward();
            //     },
            //     child: const Text('Forward')),
            // ElevatedButton(
            //     onPressed: () {
            //       _animationController.reverse();
            //     },
            //     child: const Text('Reverse')),
            ElevatedButton(
              onPressed: () async {
                _animationController.forward();

                final navigator = await Navigator.of(context)
                    .push(
                  MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          log(_animation.value.abs().toString());

                          return Opacity(
                            opacity: _animation.value.abs(),
                            child: Scaffold(
                              backgroundColor: Colors.red,
                              // AppColors.backgroundMenuViewColor,
                              // .withOpacity(_animation.value.abs()),
                              // appBar: AppBar(
                              //   title: const Text('Screen 2'),
                              // ),
                              body: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Hero(
                                  tag: 'tag',
                                  child: Container(
                                    height: 100,
                                    width: 300,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                                  // PhotoHero(
                                  //   photo:
                                  //       'https://www.emanprague.com/en/wp-content/uploads/2018/05/flutter_eman_blog.png',
                                  //   fit: BoxFit.contain,
                                  //   onTap: () {
                                  //     // _animationController.reset();
                                  //     // _animationController.forward();
                                  //     Navigator.of(context).pop();

                                  //     // _animationController.reverse().then((onValue) {
                                  //     //   _animationController.reset();
                                  //     //   _animationController.forward();
                                  //     // });
                                  //     // _animationController.forward();

                                  //     // _animationController.reverse(from: 0);
                                  //   },
                                  // ),
                                  ),
                            ),
                          );
                        },
                      );
                    },
                    fullscreenDialog: true,
                  ),
                )
                    .whenComplete(({navigator}) {
                  _animationController.reverse(from: 0.9);
                });
                // _animationController.forward();
              },
              child: const Text('Navigator'),
            ),
          ],
        ),
      ),
    );
  }
}
