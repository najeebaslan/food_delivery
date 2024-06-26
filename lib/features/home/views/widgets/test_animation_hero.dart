import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/assets_constants.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: Column(
          children: [
            const Gap(100),
            Hero(
                tag: 'tag',
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
                        height: 150,
                        width: 150,
                      ),
                    ),
                    builder: (context, child) {
                      log((rotationAnimation.value).toString());
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
                    height: 100,
                    width: 100,
                  ),
                )),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 1350),
                    reverseTransitionDuration: const Duration(milliseconds: 1350),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const NextPage(),
                      );
                    },
                  ),
                );
              },
              child: const Text('next'),
            )
          ],
        ),
      ),
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
      backgroundColor: Colors.indigo,
      appBar: PlatformAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Hero(
              tag: 'tag',
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
                    angle: rotationAnimation.value > 7 ? 5.3 : 3,
                    child: SvgPicture.asset(
                      ImagesConstants.ellipseRed,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  builder: (context, child) {
                    log((rotationAnimation.value).toString());
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
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('back'),
          )
        ],
      ),
    );
  }
}

class CustomRectTween extends RectTween {
  CustomRectTween({required Rect begin, required Rect end})
      : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    double startX = begin!.left;
    double startY = begin!.top;
    double startWidth = begin!.width;
    double startHeight = begin!.height;

    double endX = end!.left;
    double endY = end!.top;
    double endWidth = end!.width;
    double endHeight = end!.height;

    double easeInOutBackValue = Curves.easeInOutBack.transform(t);

    double animatedX = startX + (endX - startX) * easeInOutBackValue;
    double animatedY = startY + (endY - startY) * easeInOutBackValue;
    double animatedWidth = startWidth + (endWidth - startWidth) * easeInOutBackValue;
    double animatedHeight = startHeight + (endHeight - startHeight) * easeInOutBackValue;

    return Rect.fromLTWH(animatedX, animatedY, animatedWidth, animatedHeight);
  }
}
