import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

import '../../../core/styles/app_colors.dart';

part 'home_animation_state.dart';

enum PageViewEnum { menu, productDetails, empty }

enum NavigateTo { menu, productDetails }

class HomeAnimationCubit extends Cubit<HomeAnimationState> {
  HomeAnimationCubit() : super(HomeAnimationInitial());
  static HomeAnimationCubit get(BuildContext context) => BlocProvider.of(context);

  NavigateTo? navigateTo;
  Color colorBlueOrRedCircle = AppColors.red;

  PageViewEnum pageViewEnum = PageViewEnum.empty;
  late AnimationController menuAnimationController;
  late AnimationController productDetailsAnimationController;
  // Red Circle Fat
  late Animation<double> rotationRedCircleFat;
  late Animation<Size> positionRedCircleFat;
  late Animation<double> sizeRedCircleFat;
  // Yellow Circle
  late Animation<double> rotationYellowCircle;
  late Animation<Size> positionYellowCircle;
  late Animation<double> sizeYellowCircle;
  //  Green Circle
  late Animation<double> rotationGreenCircle;
  late Animation<Size> positionGreenCircle;
  late Animation<Size> sizeGreenCircle;
// List Menu Texts
  late Animation<double> heightTitlesMenuAnimation;
  late Animation<double> opacityColorMenu;
  late Animation<double> opacityColorProductDetails;
  bool hideRedCircleFat = false;
  late final curve = CurvedAnimation(
    parent: menuAnimationController,
    curve: Curves.easeInOutBack,
  );

  void setupMenuAnimations(BuildContext context) {
    // Red Circle Fat
    rotationRedCircleFat = Tween<double>(
      begin: 0.0,
      end: 2.3,
    ).animate(curve);
    positionRedCircleFat = Tween<Size>(
      begin: Size(
        55,
        context.mediaQueryOf.padding.top.h + 5.h,
      ),
      end: Size(0, context.height * 0.66),
    ).animate(curve);

    sizeRedCircleFat = Tween<double>(
      begin: 65.303,
      end: 248.46,
    ).animate(curve);
    // Yellow Circle
    rotationYellowCircle = Tween<double>(
      begin: 0.0,
      end: 2.9,
    ).animate(curve);

    positionYellowCircle = Tween<Size>(
      begin: Size(
        60,
        (context.mediaQueryOf.padding.top / 1.3).h,
      ),
      end: Size(70, context.height * 0.87),
    ).animate(curve);

    sizeYellowCircle = Tween<double>(
      begin: 36.308,
      end: 138.142,
    ).animate(curve);

    // Green Circle
    rotationGreenCircle = Tween<double>(
      begin: 3.7,
      end: 6.3,
    ).animate(curve);

    positionGreenCircle = Tween<Size>(
      begin: Size(22.w, context.mediaQueryOf.padding.top.h + 8.h),
      end: Size((context.width * 0.58).w, context.height * 0.81),
    ).animate(curve);

    sizeGreenCircle = Tween<Size>(
      begin: const Size(35.25, 34.333),
      end: const Size(134.118, 130.628),
    ).animate(curve);

    // List Menu Texts
    heightTitlesMenuAnimation = Tween<double>(
      begin: 20.0.h,
      end: 300.0.h,
    ).animate(curve);

    opacityColorMenu = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(curve);
  }

  void setupProductDetailsAnimations(BuildContext context) {
    opacityColorProductDetails = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: productDetailsAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  void startOrReverseMenuAnimation() {
    menuAnimationController.value == 0.0
        ? menuAnimationController.forward()
        : menuAnimationController.reverse().whenComplete(
              () => changePageView(PageViewEnum.empty),
            );
  }

  void startProductDetailsAnimation(BuildContext context) {
    rotationRedCircleFat = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: productDetailsAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
    positionRedCircleFat = Tween<Size>(
      begin: const Size(55, 57),
      end: Size(-60.w, context.height * 0.2),
    ).animate(
      CurvedAnimation(
        parent: productDetailsAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    sizeRedCircleFat = Tween<double>(
      begin: 65.303,
      end: 195.023,
    ).animate(
      CurvedAnimation(
        parent: productDetailsAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
    changePageView(PageViewEnum.productDetails);
    productDetailsAnimationController.forward().whenComplete(
          () => hideRedCircleFat = true,
        );
  }

  void reverseProductDetailsAnimationAndBackToHomeView() {
    hideRedCircleFat = false;
    productDetailsAnimationController.reverse();
  }

  void changePageView(PageViewEnum page) {
    pageViewEnum = page;
    emit(ChangePageView());
  }

  void navigateToView(NavigateTo to) {
    navigateTo = to;
    emit(NavigateToView());
  }

  void changeRedCircleColor(Color value) {
    colorBlueOrRedCircle = value;
    emit(ChangeRedCircleColor());
  } 

  bool get isMenuViewOrEmpty =>
      pageViewEnum == PageViewEnum.empty || pageViewEnum == PageViewEnum.menu;

  bool get isProductView => pageViewEnum == PageViewEnum.productDetails;

  bool get isMenuView => pageViewEnum == PageViewEnum.menu;
}
