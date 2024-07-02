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
  static Animation<double>? _sizeHintTextAnimations;
  static double _sizeHintText = 14;
  static FontStyle _fontStyleHintText = FontStyle.italic;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroTagsConstants.appBarTag,
      flightShuttleBuilder: (_, Animation<double> animation, __, ___, ____) {
        _sizeHintTextAnimations = Tween<double>(
          begin: 14,
          end: 16,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutBack,
          ),
        );
        changeSizeHintText();

        return PlatformWidget(
          cupertino: (context, platform) {
            return _buildAnimatedBuilder();
          },
          material: (context, platform) {
            return Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              child: _buildAnimatedBuilder(),
            );
          },
        );
      },
      child: appBarContent(),
    );
  }

  AnimatedBuilder _buildAnimatedBuilder() {
    return AnimatedBuilder(
      animation: _sizeHintTextAnimations!,
      child: faceTextField(),
      builder: (context, child) {
        return appBarContent();
      },
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
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.bottom,
        onChanged: (value) {},
        style: AppTextStyles.font14Black300W.copyWith(
          height: 0,
          fontSize: _sizeHintText.sp,
          fontStyle: _fontStyleHintText,
        ),
        decoration: InputDecoration(
          hintText: _hintText,
          hintStyle: AppTextStyles.font14Black300W.copyWith(
            height: 0,
            fontSize: _sizeHintText.sp,
            fontStyle: _fontStyleHintText,
          ),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
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
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 38.h,
          width: 374.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          child: CupertinoSearchTextField(
            borderRadius: BorderRadius.circular(30.r),
            style: AppTextStyles.font14Black300W.copyWith(
              height: 0,
              fontSize: _sizeHintText.sp,
              fontStyle: _fontStyleHintText,
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
            placeholderStyle: AppTextStyles.font14Black300W.copyWith(
              height: 0,
              fontSize: _sizeHintText.sp,
              fontStyle: _fontStyleHintText,
            ),
            onChanged: (value) {
              setState(() => valueTextField = value);
            },
            placeholder: _hintText,
          ),
        );
      },
    );
  }

  void changeSizeHintText() {
    _sizeHintTextAnimations!.addListener(() {
      if (_sizeHintTextAnimations!.value > 13) {
        _sizeHintText = _sizeHintTextAnimations!.value;
      }
      changeFontStyleHint();
    });
  }

  void changeFontStyleHint() {
    if ((_sizeHintTextAnimations!.value >= 15) && startAnimationHero == true) {
      _fontStyleHintText = FontStyle.normal;
    } else if ((_sizeHintTextAnimations!.value >= 15) && startAnimationHero == false) {
      _fontStyleHintText = FontStyle.normal;
    } else {
      _fontStyleHintText = FontStyle.italic;
    }
  }

  Widget faceTextField() {
    return Container(
      height: 38.h,
      width: 374.w,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Text(
        _hintText,
        style: AppTextStyles.font14Black300W.copyWith(
          height: 0,
          fontSize: _sizeHintText.sp,
          fontStyle: _fontStyleHintText,
        ),
      ),
    );
  }
}
