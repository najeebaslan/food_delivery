import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:food_delivery/food_delivery.dart';

import 'core/constants/assets_constants.dart';
import 'core/utils/bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // Whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
  // This line for fix hide text bugs in screen_utils in release mode
  await ScreenUtil.ensureScreenSize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await cacheSvgImagesSplashView();

  runApp(const FoodDeliveryApp());
}

Future<void> cacheSvgImagesSplashView() async {
  List<String> splashViewImagesUrl = [
    ImagesConstants.ellipseGreen,
    ImagesConstants.friesBlue,
    ImagesConstants.ellipseYellow,
    ImagesConstants.ellipseRed,
    ImagesConstants.ellipseSmall,
    ImagesConstants.burgerBlueCircle,
  ];
  for (String imageUrl in splashViewImagesUrl) {
    final svg.SvgAssetLoader loader = svg.SvgAssetLoader(imageUrl);

    await svg.Cache().putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }
}
/* 


class Dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF6F6FF)),
          child: Stack(
            children: [
              Positioned(
                left: 14,
                top: 99,
                child: Container(
                  width: 374,
                  height: 38,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 58,
                child: SizedBox(
                  width: 235,
                  height: 37,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Good moring, ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: 'Jeev jobs',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 192,
                child: SizedBox(
                  width: 235,
                  height: 37,
                  child: Text(
                    'Donuts',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 110,
                child: SizedBox(
                  width: 246,
                  height: 22,
                  child: Text(
                    'What  you wanna order today ?..',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 351,
                top: 103,
                child: Container(
                  width: 34,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 354,
                top: 108,
                child: Container(
                  width: 22,
                  height: 22,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: FlutterLogo(),
                ),
              ),
              Positioned(
                left: 192.01,
                top: 259.71,
                child: Opacity(
                  opacity: 0.10,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(2.47),
                    child: Container(
                      width: 195.02,
                      height: 195.02,
                      decoration: ShapeDecoration(
                        color: Color(0xFF4688F0),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 326.34,
                top: 265.87,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-2.69),
                  child: Container(
                    width: 78.36,
                    height: 78.36,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFABB2D),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 364,
                top: 66,
                child: Container(
                  width: 24,
                  height: 14,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 24,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 7,
                        child: Container(
                          width: 16,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 14,
                        child: Container(
                          width: 8,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 348.54,
                top: 198,
                child: Opacity(
                  opacity: 0.90,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.86),
                    child: Container(
                      width: 48.13,
                      height: 48.13,
                      decoration: ShapeDecoration(
                        color: Color(0xFFE8453C),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 328,
                child: Container(
                  width: 80,
                  height: 3,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFABB2D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 10,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 294,
                child: SizedBox(
                  width: 140,
                  height: 28,
                  child: Text(
                    'Coconut',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 328,
                child: Container(
                  width: 80,
                  height: 3,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFABB2D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 10,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 174,
                top: 307,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Text(
                        '4.5',
                        style: TextStyle(
                          color: Color(0xFFFBC957),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 1,
                      child: Container(
                        width: 16,
                        height: 16,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          ,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 26,
                top: 260,
                child: Container(
                  width: 401,
                  height: 712,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 13,
                        child: Container(
                          width: 356,
                          height: 156,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 15,
                        child: Container(
                          width: 362,
                          height: 154,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0x66FABA2C)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 76,
                        child: Text(
                          'Want a delicious meal, but no \ntime we will deliver it hot and yummy.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 125,
                        child: SizedBox(
                          width: 140,
                          height: 28,
                          child: Text(
                            '\$7.50',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 378,
                        child: Container(
                          width: 356,
                          height: 156,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 380,
                        child: Container(
                          width: 362,
                          height: 154,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0x70E8453B)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 443,
                        child: Text(
                          'Want a delicious meal, but no \ntime we will deliver it hot and yummy.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 433,
                        child: Container(
                          width: 80,
                          height: 3,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFABB2D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 399,
                        child: SizedBox(
                          width: 140,
                          height: 28,
                          child: Text(
                            'Ube',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 433,
                        child: Container(
                          width: 80,
                          height: 3,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEA574F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 556,
                        child: Container(
                          width: 356,
                          height: 156,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 558,
                        child: Container(
                          width: 362,
                          height: 154,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0x68FABA2C)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 643,
                        child: Text(
                          'Want a delicious meal, but no \ntime we will deliver it hot and yummy.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 643,
                        child: Text(
                          'Want a delicious meal, but no \ntime we will deliver it hot and yummy.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 261,
                        top: 586,
                        child: SizedBox(
                          width: 140,
                          height: 28,
                          child: Text(
                            'Vanilla',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 264,
                        top: 620,
                        child: Container(
                          width: 80,
                          height: 3,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFABB2D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 499,
                        child: SizedBox(
                          width: 140,
                          height: 28,
                          child: Text(
                            '\$3.50',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 253,
                        top: 361,
                        child: Container(
                          width: 118,
                          height: 118,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 118,
                                  height: 118,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 118,
                                          height: 118,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/118x118"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 118,
                                          height: 118,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 118,
                                                  height: 118,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/118x118"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 118,
                                                  height: 118,
                                                  decoration: BoxDecoration(color: Color(0xFFDF9A49)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 118,
                                  height: 118,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 118,
                                          height: 118,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/118x118"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 118,
                                          height: 118,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 118,
                                                  height: 118,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/118x118"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 118,
                                                  height: 118,
                                                  decoration: BoxDecoration(color: Color(0xFF7B4CDF)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 118,
                                  height: 118,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 118,
                                          height: 118,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/118x118"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 118,
                                          height: 118,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 118,
                                                  height: 118,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/118x118"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 118,
                                                  height: 118,
                                                  decoration: BoxDecoration(color: Color(0xFFF157FF)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 528,
                        child: Container(
                          width: 131,
                          height: 131,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 131,
                                  height: 131,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 131,
                                          height: 131,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/131x131"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 131,
                                          height: 131,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 131,
                                                  height: 131,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/131x131"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 131,
                                                  height: 131,
                                                  decoration: BoxDecoration(color: Color(0xFFDF9A49)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 131,
                                  height: 131,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 131,
                                          height: 131,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/131x131"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 131,
                                          height: 131,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 131,
                                                  height: 131,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/131x131"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 131,
                                                  height: 131,
                                                  decoration: BoxDecoration(color: Color(0xFF7B4CDF)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 131,
                                  height: 131,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 131,
                                          height: 131,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/131x131"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 131,
                                          height: 131,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 131,
                                                  height: 131,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/131x131"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 131,
                                                  height: 131,
                                                  decoration: BoxDecoration(color: Color(0xFFF157FF)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 245,
                        top: 0,
                        child: Container(
                          width: 130,
                          height: 130,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/130x130"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 130,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/130x130"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 130,
                                                  height: 130,
                                                  decoration: BoxDecoration(color: Color(0xFFDF9A49)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/130x130"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 130,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/130x130"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 130,
                                                  height: 130,
                                                  decoration: BoxDecoration(color: Color(0xFF7B4CDF)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/130x130"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 130,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage("https://via.placeholder.com/130x130"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 130,
                                                  height: 130,
                                                  decoration: BoxDecoration(color: Color(0xFFF157FF)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 191,
                        child: Container(
                          width: 376,
                          height: 156,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 305.59,
                                top: 129.37,
                                child: Opacity(
                                  opacity: 0.20,
                                  child: Transform(
                                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(2.98),
                                    child: Container(
                                      width: 126.29,
                                      height: 123,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF3AA856),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 356,
                                  height: 156,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 362,
                                  height: 154,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1, color: Color(0xA04DB066)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 10,
                                        offset: Offset(0, 10),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 236,
                                top: 117,
                                child: SizedBox(
                                  width: 140,
                                  height: 28,
                                  child: Text(
                                    '\$17.30',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 115,
                                top: 63,
                                child: Text(
                                  'Want a delicious meal, but no \ntime we will deliver it hot and yummy.',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 233,
                                top: 21,
                                child: SizedBox(
                                  width: 140,
                                  height: 28,
                                  child: Text(
                                    'Spudnut',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 261,
                                top: 57,
                                child: Container(
                                  width: 80,
                                  height: 3,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF4DB066),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 10,
                                        offset: Offset(0, 10),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 313,
                                top: 116,
                                child: Container(
                                  width: 28,
                                  height: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 28,
                                          height: 24,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF4DB066),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 313,
                        top: 129,
                        child: Container(
                          width: 28,
                          height: 24,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 28,
                                  height: 24,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF4DB066),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 313,
                        top: 499,
                        child: Container(
                          width: 28,
                          height: 24,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 28,
                                  height: 24,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF4DB066),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 446,
                child: Container(
                  width: 117,
                  height: 117,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 117,
                          height: 117,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 117,
                                  height: 117,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https://via.placeholder.com/117x117"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 117,
                                  height: 117,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 117,
                                          height: 117,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/117x117"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 117,
                                          height: 117,
                                          decoration: BoxDecoration(color: Color(0xFFDF9A49)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 117,
                          height: 117,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 117,
                                  height: 117,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https://via.placeholder.com/117x117"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 117,
                                  height: 117,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 117,
                                          height: 117,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/117x117"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 117,
                                          height: 117,
                                          decoration: BoxDecoration(color: Color(0xFF7B4CDF)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 10.06,
                        child: Container(
                          width: 117,
                          height: 106.94,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 117,
                                  height: 106.94,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https://via.placeholder.com/117x107"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 117,
                                  height: 106.94,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 117,
                                          height: 106.94,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/117x107"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: -0.21,
                                        child: Container(
                                          width: 117,
                                          height: 106.94,
                                          decoration: BoxDecoration(color: Color(0xFFF157FF)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 84,
                top: 802.92,
                child: Opacity(
                  opacity: 0,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                    child: Container(
                      width: 224.53,
                      height: 224.53,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Transform(
                              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                              child: Container(
                                width: 224.53,
                                height: 224.53,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Transform(
                                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                        child: Container(
                                          width: 224.53,
                                          height: 224.53,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/225x225"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Transform(
                                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                        child: Container(
                                          width: 224.53,
                                          height: 224.53,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Transform(
                                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                                  child: Container(
                                                    width: 224.53,
                                                    height: 224.53,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage("https://via.placeholder.com/225x225"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Transform(
                                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                                  child: Container(
                                                    width: 224.53,
                                                    height: 224.53,
                                                    decoration: BoxDecoration(color: Color(0xFFDF9A49)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Transform(
                              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                              child: Container(
                                width: 224.53,
                                height: 224.53,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Transform(
                                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                        child: Container(
                                          width: 224.53,
                                          height: 224.53,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/225x225"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Transform(
                                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                        child: Container(
                                          width: 224.53,
                                          height: 224.53,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Transform(
                                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                                  child: Container(
                                                    width: 224.53,
                                                    height: 224.53,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage("https://via.placeholder.com/225x225"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Transform(
                                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                                  child: Container(
                                                    width: 224.53,
                                                    height: 224.53,
                                                    decoration: BoxDecoration(color: Color(0xFF7B4CDF)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Transform(
                              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                              child: Container(
                                width: 224.53,
                                height: 224.53,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Transform(
                                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                        child: Container(
                                          width: 224.53,
                                          height: 224.53,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https://via.placeholder.com/225x225"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Transform(
                                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                        child: Container(
                                          width: 224.53,
                                          height: 224.53,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Transform(
                                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                                  child: Container(
                                                    width: 224.53,
                                                    height: 224.53,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage("https://via.placeholder.com/225x225"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Transform(
                                                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.18),
                                                  child: Container(
                                                    width: 224.53,
                                                    height: 224.53,
                                                    decoration: BoxDecoration(color: Color(0xFFF157FF)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
 */