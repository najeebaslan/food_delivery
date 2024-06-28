import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';

import '../../../core/constants/assets_constants.dart';

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
                PlatformText('Fast delivery',
                    style: AppTextStyles.font40Black400W.copyWith(
                      height: 0,
                    )),
                PlatformText(
                  'Taste that best, its on time.',
                  style: AppTextStyles.font20Black300W.copyWith(
                    height: 0,
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
