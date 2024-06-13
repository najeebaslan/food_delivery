import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/utils/utils_images.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
            SvgPicture.string(ellipseWithColor("#4688F0")),
            SvgPicture.string(ellipseWithColor("#E8453C")),
            // SvgPicture.asset('assets/images/ellipse.svg')
          ]),
    );
  }
}
