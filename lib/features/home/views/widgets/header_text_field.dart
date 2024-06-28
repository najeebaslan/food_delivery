import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';

import '../../../../core/constants/hero_tags_constants.dart';

class HeaderTextField extends StatelessWidget {
  const HeaderTextField({super.key, this.startAnimationHero = false});
  static const String _hintText = 'What you wanna order today ?..';
  final bool startAnimationHero;
  static Animation<double>? sizeHintTextAnimations;
  static double sizeHintText = 14;
  static FontStyle fontStyleHintText = FontStyle.italic;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -14.h),
      child: Hero(
        tag: HeroTagsConstants.appBarTag,
        flightShuttleBuilder: (_, Animation<double> animation, __, ___, ____) {
          sizeHintTextAnimations = Tween<double>(
            begin: 14,
            end: 16,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutBack,
            ),
          );
          changeSizeHintText();
          return AnimatedBuilder(
            animation: sizeHintTextAnimations!,
            child: appBarContent(),
            builder: (context, child) {
              return appBarContent();
            },
          );
        },
        child: appBarContent(),
      ),
    );
  }

  PlatformWidget appBarContent() {
    return PlatformWidget(
      cupertino: (_, __) => _buildIOSSearchTextField(),
      material: (_, __) => _buildAndroidSearchTextField(),
    );
  }

  Widget _buildAndroidSearchTextField() {
    return Container(
      height: 38.h,
      width: 374.w,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.bottom,
        onChanged: (value) {
          debugPrint(value);
        },
        style: AppTextStyles.font16Black300W.copyWith(
          height: 0,
          fontSize: startAnimationHero ? 16.sp : null,
          fontStyle: startAnimationHero ? FontStyle.normal : FontStyle.italic,
        ),
        decoration: InputDecoration(
          hintText: _hintText,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintStyle: AppTextStyles.font16Black300W.copyWith(
            height: 0,
            fontSize: startAnimationHero ? 16.sp : null,
            fontStyle: startAnimationHero ? FontStyle.normal : FontStyle.italic,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(7),
            child: SvgPicture.asset(
              ImagesConstants.iconsSearch,
              height: 20.h,
              width: 20.w,
              allowDrawingOutsideViewBox: false,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIOSSearchTextField() {
    String valueTextField = '';
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        StatefulBuilder(
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
                style: AppTextStyles.font14Black300W.copyWith(
                  height: 0,
                  fontSize: startAnimationHero ? 16.sp : null,
                  fontStyle: startAnimationHero ? FontStyle.normal : FontStyle.italic,
                ),
                suffixMode: OverlayVisibilityMode.always,
                prefixIcon: const SizedBox.shrink(),
                suffixIcon: valueTextField.isEmpty
                    ? Icon(
                        CupertinoIcons.search,
                        color: AppColors.black,
                        size: 25.w,
                      )
                    : const Icon(
                        CupertinoIcons.xmark_circle_fill,
                      ),
                backgroundColor: AppColors.white,
                onChanged: (value) {
                  setState(() => valueTextField = value);
                  debugPrint(value);
                },
                placeholder: '',
              ),
            );
          },
        ),
        Positioned(
          left: 14.w,
          child: Text(
            HeaderTextField._hintText,
            style: AppTextStyles.font14Black300W.copyWith(
              height: 0,
              fontSize: sizeHintText.sp,
              fontStyle: HeaderTextField.fontStyleHintText,
            ),
          ),
        ),
      ],
    );
  }

  void changeSizeHintText() {
    sizeHintTextAnimations!.addListener(() {
      if (sizeHintTextAnimations!.value > 13) {
        sizeHintText = sizeHintTextAnimations!.value;
      }
      changeFontStyleHint();
    });
  }

  void changeFontStyleHint() {
    if ((sizeHintTextAnimations!.value >= 15) && startAnimationHero == true) {
      fontStyleHintText = FontStyle.normal;
    } else if ((sizeHintTextAnimations!.value >= 15) && startAnimationHero == false) {
      fontStyleHintText = FontStyle.normal;
    } else {
      fontStyleHintText = FontStyle.italic;
    }
  }
}
