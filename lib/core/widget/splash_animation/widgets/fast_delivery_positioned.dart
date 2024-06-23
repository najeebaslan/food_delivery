import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/assets_constants.dart';
import '../../../styles/color_hex.dart';

class FastDeliveryPositioned extends StatelessWidget {
  const FastDeliveryPositioned({
    super.key,
    required this.height,
    required this.opacityFastDelivery,
  });

  final double height;
  final ValueNotifier<double> opacityFastDelivery;

  @override
  Widget build(BuildContext context) {
    log('rebuild FastDeliveryPositioned');
    log(opacityFastDelivery.value.toString());
    return Positioned(
      top: height / 10,
      child: ValueListenableBuilder(
        valueListenable: opacityFastDelivery,
        builder: (context, value, child) {
          return AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: value,
            child: Column(
              children: [
                SvgPicture.asset(
                  ImagesConstants.ellipseSmall,
                  width: 114.06.w,
                  height: 84.97.h,
                ),
                Text(
                  'Fast delivery',
                  style: TextStyle(
                    height: 0,
                    fontSize: 40.sp,
                    color: HexColor("#000000"),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Taste that best, its on time.',
                  style: TextStyle(
                    fontSize: 20.sp,
                    height: 0,
                    color: HexColor("#000000"),
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
