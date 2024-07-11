import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/styles/app_colors.dart';

part 'home_state.dart';

enum NavigateTo { menu, productDetails }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  NavigateTo? navigateTo;
  Color colorBlueOrRedCircle = AppColors.red;

  void navigateToView(NavigateTo to) {
    navigateTo = to;
    emit(NavigateToView(navigateTo!));
  }

  void changeRedCircleColor(Color value) {
    colorBlueOrRedCircle = value;
    emit(ChangeRedCircleColor());
  }
}





/* 
To.Marzeem.203        =====5675



To.Aljoran.208

to ozoba       5790

 */


/// vlan not add it in the router
/* 

- change channel nanoStation joran and do test speed for it
- connection 8 nanoStation for any access point 
- connection ozobah nanoStation for any access point 











 */