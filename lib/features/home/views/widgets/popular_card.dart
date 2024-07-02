import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/core/widget/shadow.dart';
import 'package:gap/gap.dart';

import '../../blocs/home_animation_cubit/home_animation_cubit.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUri,
    this.customImage,
    required this.colorForLineTitle,
  });
  final String title;
  final String imageUri;
  final String subtitle;
  final String description;
  final Color colorForLineTitle;
  final Widget? customImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeAnimationCubit>()
      .startProductDetailsAnimation(context),
      child: Container(
        width: 362.w,
        height: 154.h,
        padding: EdgeInsets.only(
          right: 19.w,
          left: 16.w,
          top: 18.h,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 10,
              offset: Offset(0, 10),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            customImage ??
                Positioned(
                  bottom: 58.h,
                  right: -70.w,
                  child: SimpleShadow(
                    color: const Color(0x26000000),
                    offset: const Offset(-4, -1),
                    sigma: 10,
                    child: Image.asset(
                      imageUri,
                      width: 199.w,
                      height: 199.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      style: AppTextStyles.font30Black400W.copyWith(
                        height: 0,
                      ),
                    ),
                    Gap(2.w),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index == 4 ? Icons.star_half : Icons.star,
                          size: 22.w,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -5.h),
                      child: Container(
                        width: 85.w,
                        height: 3.h,
                        padding: EdgeInsets.zero,
                        decoration: ShapeDecoration(
                          color: colorForLineTitle,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          shadows: const [
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
                    Gap(20.w),
                    AutoSizeText(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16Black300W.copyWith(
                        fontStyle: FontStyle.italic,
                        height: 0.8,
                      ),
                    ),
                  ],
                ),
                Gap(12.h),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 324.w,
                  ),
                  child: AutoSizeText(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    group: AutoSizeGroup(),
                    style: AppTextStyles.font14Black400W.copyWith(
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
