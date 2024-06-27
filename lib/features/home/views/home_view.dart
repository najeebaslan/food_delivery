import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/core/widget/shadow.dart';
import 'package:food_delivery/features/home/views/widgets/popular_list_items.dart';
import 'package:gap/gap.dart';

import '../../../core/widget/animation_slide_transition.dart';
import 'widgets/app_bar/app_bar_home_view.dart';
import 'widgets/text_field_with_categories_animation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.redCircleTag});
  final String redCircleTag;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: AppColors.homeBackground,
      body: Padding(
        padding: EdgeInsets.only(
          right: 24.w,
          left: 24.w,
          top: 47.h,
        ),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBarHomeView(redCircleTag: redCircleTag),
              Gap(10.h),
              const TextFieldWithCategoriesAnimation(),
              AnimationSlideTransition(
                delay: 0,
                direction: 'down',
                milliseconds: 300,
                startFromBottom: -0.1,
                child: Column(
                  children: [
                    Gap(47.h),
                    Align(
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
                    Gap(30.h),
                    PopularListItems(
                      title: 'Hotdog',
                      subtitle: 'Top of the day',
                      description:
                          'The term hot dog can also refer to the sausage itself. The sausage used is a wiener or a frankfurter.',
                      imageUri: ImagesConstants.hotDogIsometric,
                      colorForLineTitle: AppColors.blue,
                    ),
                    Gap(49.h),
                    PopularListItems(
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
                    PopularListItems(
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
                          color: const Color(0x26000000),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
