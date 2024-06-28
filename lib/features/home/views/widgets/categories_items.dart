import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class CategoriesItems extends StatelessWidget {
  const CategoriesItems({
    super.key,
    required this.transformCardAll,
    required this.transformBurger,
  });
  final Animation<double> transformCardAll;
  final Animation<double> transformBurger;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 0,
          child: Transform.translate(
            offset: Offset(transformCardAll.value.w, 0),
            child: Container(
              height: 118.h,
              width: 81.w,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: AppColors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: PlatformText(
                'All',
                style: AppTextStyles.font16Black400W.copyWith(
                  height: 0,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: Transform.translate(
            offset: Offset(transformCardAll.value.w + 12.w, 0),
            child: _buildCard(
              imageUri: ImagesConstants.homeBoxDonut,
              isBurger: false,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Transform.translate(
            offset: Offset(-transformBurger.value.w, 0),
            child: _buildCard(
              imageUri: ImagesConstants.burgerIsometric,
              isBurger: true,
            ),
          ),
        ),
      ],
    );
  }

  Stack _buildCard({required String imageUri, required bool isBurger}) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 83.h,
          width: 130.w,
          decoration: ShapeDecoration(
            color: isBurger ? AppColors.green : AppColors.nearRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
          ),
        ),
        Positioned(
          top: isBurger ? -90.h : -60.h,
          child: isBurger
              ? Container(
                  width: 170.74.w,
                  height: 170.74.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageUri),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              : Image.asset(
                  imageUri,
                  width: isBurger ? 170.74.w : 121.w,
                  height: isBurger ? 170.74.h : 121.h,
                ),
        ),
        Positioned(
          bottom: 6.5.h,
          child: PlatformText(
            isBurger ? 'Burger' : 'Donut',
            style: AppTextStyles.font30White300W.copyWith(
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}
