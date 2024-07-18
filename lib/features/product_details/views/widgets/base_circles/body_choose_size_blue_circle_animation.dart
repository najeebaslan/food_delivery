import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../home/views/widgets/base_circles/hero_red_circle_app_bar_home_view.dart';
import '../../../cubit/product_details_cubit.dart';
import 'hero_blue_circle_product.dart';

class BodyChooseSizeBlueCircleAnimation extends StatelessWidget {
  const BodyChooseSizeBlueCircleAnimation({
    super.key,
    required this.productCubit,
    required this.adaptiveCurve,
    required this.isChangeCircleFromMediumToSmall,
    required this.isChangeCircleFromMediumToMedium,
    required this.isChangeCircleFromSmallToMedium,
    required this.isChangeCircleFromMediumToLarge,
    required this.isChangeCircleFromLargeToMedium,
    required this.isChangeCircleFromLargeToSmall,
    required this.isChangeCircleFromSmallToLarge,
  });
  final ProductDetailsCubit productCubit;
  final bool isChangeCircleFromMediumToSmall;
  final bool isChangeCircleFromMediumToMedium;
  final bool isChangeCircleFromSmallToMedium;
  final bool isChangeCircleFromMediumToLarge;
  final bool isChangeCircleFromLargeToMedium;
  final bool isChangeCircleFromLargeToSmall;
  final bool isChangeCircleFromSmallToLarge;

  final CurvedAnimation adaptiveCurve;
  @override
  Widget build(BuildContext context) {
    final historySizeList = productCubit.historySizeList;

    final lastSize = historySizeList.isNotEmpty ? historySizeList.last : null;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (isChangeCircleFromMediumToSmall) ...[
          _greenCircleWidget(),
          _blueCircleWidget(
            circleOpacity.value.clamp(0.0, 1.0),
          )
        ] else if (isChangeCircleFromSmallToMedium) ...[
          _greenCircleWidget(
            circleOpacity.value.clamp(0.0, 1.0),
          ),
          _blueCircleWidget(),
        ] else if (isChangeCircleFromMediumToLarge) ...[
          _yellowCircleWidget(),
          _blueCircleWidget(
            circleOpacity.value.clamp(0.0, 1.0),
          ),
        ] else if (isChangeCircleFromLargeToMedium) ...[
          _yellowCircleWidget(
            circleOpacity.value.clamp(0.0, 1.0),
          ),
          _blueCircleWidget(),
        ] else if (isChangeCircleFromLargeToSmall) ...[
          _yellowCircleWidget(),
          _greenCircleWidget(
            circleOpacity.value.clamp(0.0, 1.0),
          ),
        ] else if (isChangeCircleFromSmallToLarge) ...[
          if (lastSize == ProductDetailsSizeEnum.medium) ...[
            _greenCircleWidget(),
            _yellowCircleWidget(
              circleOpacity.value.clamp(0.0, 1.0),
            ),
          ] else ...[
            _greenCircleWidget(
              circleOpacity.value.clamp(0.0, 1.0),
            ),
            _yellowCircleWidget(),
          ]
        ] else
          _blueCircleWidget(),
      ],
    );
  }

  Transform _yellowCircleWidget([double? colorOpacity]) {
    return Transform.rotate(
      angle: 1.3,
      child: SvgPicture.asset(
        ImagesConstants.chooseSizeYellowCircle,
        width: 190.02.w,
        height: 193.02.h,
        colorFilter: ColorFilter.mode(
          AppColors.yellow.withOpacity(
            colorOpacity ?? yellowCircleOpacity.value.clamp(0.0, 1.0),
          ),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Transform _greenCircleWidget([double? colorOpacity]) {
    return Transform.rotate(
      angle: 2,
      child: SvgPicture.asset(
        ImagesConstants.chooseSizeGreenCircle,
        width: 189.02.w,
        height: 189.02.h,
        colorFilter: ColorFilter.mode(
          AppColors.green.withOpacity(
            colorOpacity ?? greenCircleOpacity.value.clamp(0.0, 1.0),
          ),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  HeroBlueCircleProduct _blueCircleWidget([double? colorOpacity]) {
    return HeroBlueCircleProduct(
      parameters: HeroRedCircleParameters(
        showProductDetails: productCubit.isProductDetailsVisible,
        width: 195.02.w,
        height: 195.02.h,
        angle: 4,
        color: isChangeCircleFromMediumToMedium
            ? AppColors.blue
            : AppColors.blue.withOpacity(
                colorOpacity ?? blueCircleOpacity.value.clamp(0.0, 1.0),
              ),
      ),
    );
  }

  Animation<double> get greenCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(adaptiveCurve);
  Animation<double> get circleOpacity =>
      Tween(begin: 1.0, end: 0.0).animate(adaptiveCurve);

  Animation<double> get yellowCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(adaptiveCurve);

  Animation<double> get blueCircleOpacity =>
      Tween(begin: 0.0, end: 1.0).animate(adaptiveCurve);
}
