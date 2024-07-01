import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/core/constants/assets_constants.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';

class HeaderTextField extends StatefulWidget {
  const HeaderTextField({super.key, this.startAnimationHero = false});
  final bool startAnimationHero;

  @override
  State<HeaderTextField> createState() => _HeaderTextFieldState();
}

class _HeaderTextFieldState extends State<HeaderTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  static const String _hintText = 'What you wanna order today ?..';
  static const double _sizeHintText = 14;
  static const FontStyle _fontStyleHintText = FontStyle.italic;

  @override
  void initState() {
    super.initState();
    setupAnimationSlider();
  }

  void setupAnimationSlider() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: const Offset(0, 0.01),
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: appBarContent(),
            ),
          ),
        );
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
}

