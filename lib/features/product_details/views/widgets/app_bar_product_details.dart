import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/hero_tags_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/custom_rect_tween.dart';
import '../../../home/blocs/home_animation_cubit/home_animation_cubit.dart';
import '../../../home/blocs/home_cubit/home_cubit.dart';

class AppBarProductDetails extends StatefulWidget {
  const AppBarProductDetails({
    super.key,
    this.redCircleTag,
    this.showIconMenuWithTitleOnly = false,
    this.backFrom = NavigateTo.menu,
  });

  final String? redCircleTag;
  final bool showIconMenuWithTitleOnly;
  final NavigateTo backFrom;

  @override
  State<AppBarProductDetails> createState() => _AppBarProductDetailsState();
}

class _AppBarProductDetailsState extends State<AppBarProductDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 0.w, height: 65.30.h), // This for make ui responsive
        GoodMorningTitleWithHero(
          showIconMenuWithTitleOnly: widget.showIconMenuWithTitleOnly,
        ),
        const Spacer(),
        _menuIconButton(context),
      ],
    );
  }

  PlatformIconButton _menuIconButton(BuildContext context) {
    return PlatformIconButton(
      onPressed: () {
        context.read<HomeAnimationCubit>()
          ..startOrReverseMenuAnimation()
          ..changePageView(PageViewEnum.menu);
      },
      icon: SvgPicture.asset(
        ImagesConstants.homeMenuIcon,
        height: 14.h,
        width: 24.w,
      ),
    );
  }
}

class GoodMorningTitleWithHero extends StatelessWidget {
  const GoodMorningTitleWithHero({
    super.key,
    required this.showIconMenuWithTitleOnly,
  });
  final bool showIconMenuWithTitleOnly;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(showIconMenuWithTitleOnly == true ? 10 : -15.w, 0),
      child: Hero(
        tag: HeroTagsConstants.titleAppBarTag,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          if (context.isIOS) {
            return _buildAnimatedBuilder(animation);
          } else {
            return Material(
              color: Colors.transparent,
              child: _buildAnimatedBuilder(animation),
            );
          }
        },
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: _goodMorningTitle(),
      ),
    );
  }

  AnimatedBuilder _buildAnimatedBuilder(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      child: _goodMorningTitle(),
      builder: (context, child) => _goodMorningTitle(),
    );
  }

  Widget _goodMorningTitle() {
    return Text.rich(
      textAlign: TextAlign.left,
      TextSpan(
        children: [
          TextSpan(
            text: 'Good morning, ',
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
    );
  }
}
