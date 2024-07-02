import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

part 'home_animation_state.dart';

enum PageViewEnum { menu, productDetails, empty }

class HomeAnimationCubit extends Cubit<HomeAnimationState> {
  HomeAnimationCubit() : super(HomeAnimationInitial());
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
  late Animation<double> sizeGreenCircle;
// List Menu Texts
  late Animation<double> heightTitlesMenuAnimation;
  late Animation<double> opacityColorMenu;
  late Animation<double> opacityColorProductDetails;
  bool hideRedCircleFat = false;
  late final curve = CurvedAnimation(
    parent: menuAnimationController,
    curve: Curves.easeInOutBack,
  );

  void setupMenuAnimations(BuildContext context, [bool? isTest]) {
    // Red Circle Fat
    rotationRedCircleFat = Tween<double>(
      begin: 0.0,
      end: 2.3,
    ).animate(curve);
    positionRedCircleFat = Tween<Size>(
      begin: const Size(55, 57),
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
      begin: const Size(60, 40),
      end: Size(70, context.height * 0.87),
    ).animate(curve);

    sizeYellowCircle = Tween<double>(
      begin: 36.308,
      end: 138.142,
    ).animate(curve);

    // Green Circle
    rotationGreenCircle = Tween<double>(
      begin: 0.0,
      end: 5.2,
    ).animate(curve);

    positionGreenCircle = Tween<Size>(
      begin: Size(24.w, 70),
      end: Size(context.width * 0.58, context.height * 0.81),
    ).animate(curve);

    sizeGreenCircle = Tween<double>(
      begin: isTest != null ? 100 : 32.25,
      end: isTest != null ? 200 : 134.118,
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
    productDetailsAnimationController.reverse().then((onValue){
    // changePageView(PageViewEnum.empty);

    });

    // .whenComplete(
    //       () =>
    //     );
  }

  void changePageView(PageViewEnum page) {
    pageViewEnum = page;
    emit(ChangePageView());
  }

  bool get isMenuView {
    return pageViewEnum == PageViewEnum.empty || pageViewEnum == PageViewEnum.menu;
  }

  bool get isProductView {
    return pageViewEnum == PageViewEnum.productDetails;
  }
}
