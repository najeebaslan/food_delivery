import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/color_hex.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/widget/custom_eect_tween.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: AppColors.backgroundMenuViewColor,
      body: Column(
        children: [
          const Gap(50),
          Hero(
            tag: 'tag',
            transitionOnUserGestures: true,
            createRectTween: (begin, end) {
              return CustomRectTween(
                begin: begin!,
                end: end!,
              );
            },
            flightShuttleBuilder: (_, Animation<double> animation, __, ___, ____) {
              final rotationAnimation = Tween<double>(
                begin: 0.0,
                end: 2.3,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutBack,
                ),
              );

              return AnimatedBuilder(
                animation: rotationAnimation,
                child: Transform.rotate(
                  angle: rotationAnimation.value > 0.7 ? 3 : -2.3,
                  child: SvgPicture.asset(
                    ImagesConstants.ellipseRed,
                    height: 63,
                    width: 63,
                  ),
                ),
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()..rotateZ(rotationAnimation.value),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
              );
            },
            child: Transform.rotate(
              angle: 3,
              child: SvgPicture.asset(
                ImagesConstants.ellipseRed,
                height: 63,
                width: 63,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, _pageRouteBuilder());
            },
            child: const Text('next'),
          )
        ],
      ),
    );
  }

  PageRouteBuilder _pageRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return const NextPage();
      },
      transitionDuration: const Duration(milliseconds: 2000),
      reverseTransitionDuration: const Duration(milliseconds: 2000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

class NextPage extends StatefulWidget {
  const NextPage({super.key});
  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: HexColor('#F6F6FF'),
      appBar: PlatformAppBar(
        backgroundColor: HexColor('#F6F6FF'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Hero(
            tag: 'tag',
            flightShuttleBuilder: (
              _,
              Animation<double> animation,
              __,
              ___,
              ____,
            ) {
              final rotationAnimation = Tween<double>(
                begin: 0.0,
                end: 2.3,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutBack,
                ),
              );

              return AnimatedBuilder(
                animation: rotationAnimation,
                child: Transform.rotate(
                  angle: rotationAnimation.value > 7 ? 5.3 : 3,
                  child: SvgPicture.asset(
                    ImagesConstants.ellipseRed,
                    height: 248.46,
                    width: 248.46,
                  ),
                ),
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()..rotateZ(rotationAnimation.value),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
              );
            },
            createRectTween: (begin, end) {
              return CustomRectTween(
                begin: begin!,
                end: end!,
              );
            },
            child: Transform.rotate(
              angle: 5.3,
              child: SvgPicture.asset(
                ImagesConstants.ellipseRed,
                height: 248.46,
                width: 248.46,
              ),
            ),
          ),
          const Gap(90),
        ],
      ),
    );
  }
}

