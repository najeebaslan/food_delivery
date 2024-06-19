import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/styles/app_colors.dart';

class HeaderHomeView extends StatelessWidget {
  const HeaderHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PlatformWidget(
          cupertino: (_, __) => _buildIOSSearchTextField(),
          material: (_, __) => _buildAndroidSearchTextField(),
        )
      ],
    );
  }

  Widget _buildAndroidSearchTextField() {
    return Container(
      height: 38.h,
      width: 374.w,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: TextField(
        onChanged: (value) {
          debugPrint(value);
        },
        style: AppTextStyles.font16Black300W.copyWith(
          height: 0,
          fontStyle: FontStyle.italic,
        ),
        decoration: InputDecoration(
          hintText: 'What you wanna order today ?..',
          border: const OutlineInputBorder(),
          hintStyle: AppTextStyles.font16Black300W.copyWith(
            height: 0,
            fontStyle: FontStyle.italic,
          ),
          suffixIcon: SvgPicture.asset(
            ImagesConstants.iconsSearch,
            height: 20.h,
            width: 20.w,
          ),
          //     Icon(
          //   Icons.search,
          //   color: AppColors.black,
          //   size: 20,
          // ),
        ),
      ),
    );
  }

  Widget _buildIOSSearchTextField() {
    String valueTextField = '';
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 38.h,
          width: 374.w,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: CupertinoSearchTextField(
            borderRadius: BorderRadius.circular(30),
            style: AppTextStyles.font16Black300W.copyWith(
              height: 0,
              fontStyle: FontStyle.italic,
            ),
            suffixMode: OverlayVisibilityMode.always,
            prefixIcon: const SizedBox.shrink(),
            suffixIcon: valueTextField.isEmpty
                ? Icon(
                    CupertinoIcons.search,
                    color: AppColors.black,
                    size: 20,
                  )
                : const Icon(
                    CupertinoIcons.xmark_circle_fill,
                  ),
            backgroundColor: AppColors.white,
            onChanged: (value) {
              setState(() => valueTextField = value);
              debugPrint(value);
            },
            placeholderStyle: AppTextStyles.font16Black300W.copyWith(
              height: 0,
              fontStyle: FontStyle.italic,
            ),
            placeholder: 'What you wanna order today ?..',
          ),
        );
      },
    );
  }
}
