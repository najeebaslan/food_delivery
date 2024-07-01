import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widget/animation_slide_transition.dart';
import '../../../../core/widget/shadow.dart';
import 'popular_card.dart';

class PopularListItems extends StatelessWidget {
  const PopularListItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationSlideTransition(
      delay: 50,
      direction: 'down',
      milliseconds: 150,
      startFromBottom: -0.1,
      child: Column(
        children: [
          Gap(47.h),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 37.h,
                  maxWidth: 235.w,
                ),
                child: PlatformText(
                  'Popular',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.font20White700W.copyWith(
                    color: AppColors.black,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
          Gap(30.h),
          PopularCard(
            title: 'Hotdog',
            subtitle: 'Top of the day',
            description:
                'The term hot dog can also refer to the sausage itself. The sausage used is a wiener or a frankfurter.',
            imageUri: ImagesConstants.hotDogIsometric,
            colorForLineTitle: AppColors.blue,
          ),
          Gap(49.h),
          PopularCard(
            title: 'Donut',
            subtitle: 'Top of the week',
            description:
                'A doughnut or donut is a type of leavened fried dough. It is popular in many countries and is prepared in various forms as a sweet snack ',
            imageUri: ImagesConstants.homeBoxDonut,
            colorForLineTitle: AppColors.red,
            customImage: Positioned(
              bottom: 60.h,
              right: -40.w,
              child: SimpleShadow(
                color: const Color(0x26000000),
                offset: const Offset(-4, -1),
                sigma: 10,
                child: Image.asset(
                  ImagesConstants.homeBoxDonut,
                  width: 130.w,
                  height: 130.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Gap(49.h),
          PopularCard(
            title: 'Donut',
            subtitle: 'Top of the month',
            description:
                'A doughnut or donut is a type of leavened fried dough. It is popular in many countries and is prepared in various forms as a sweet snack ',
            imageUri: ImagesConstants.friesFront,
            colorForLineTitle: AppColors.green,
            customImage: Positioned(
              bottom: 20.h,
              right: -70.w,
              child: SimpleShadow(
                color: AppColors.black.withOpacity(0.15),
                offset: const Offset(-4, -1),
                sigma: 10,
                child: Image.asset(
                  ImagesConstants.friesFront,
                  width: 190.w,
                  height: 190.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Gap(49.h),
        ],
      ),
    );
  }
}
