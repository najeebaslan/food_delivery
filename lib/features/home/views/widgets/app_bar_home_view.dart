import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_text_styles.dart';

class AppBarHomeView extends StatelessWidget {
  const AppBarHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(30.w, -10.h),
          child: Transform.rotate(
            angle: 6,
            child: SvgPicture.asset(
              ImagesConstants.onboardingCircleBoldYellow,
              height: 32.28.h,
              width: 32.28.w,
            ),
          ),
        ),
        Row(
          children: [
            Transform.rotate(
              angle: 6,
              child: SvgPicture.asset(
                ImagesConstants.ellipseRed,
                height: 32.28.h,
                width: 32.28.w,
              ),
            ),
            Transform.translate(
              offset: Offset(1.w, 0),
              child: Opacity(
                opacity: 0.10,
                child: Transform.rotate(
                  angle: 2.8,
                  child: SvgPicture.asset(
                    ImagesConstants.ellipseRed,
                    height: 65.30.h,
                    width: 65.30.w,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(-43.w, 0),
              child: Text.rich(
                textAlign: TextAlign.left,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Good moring, ',
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
            ),
            const Spacer(),
            SvgPicture.asset(
              ImagesConstants.homeMenu,
            ),
          ],
        ),
      ],
    );
  }
}
