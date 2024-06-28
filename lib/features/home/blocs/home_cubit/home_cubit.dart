import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  ValueNotifier<double> animationTransition = ValueNotifier(0.0);
  double sizeTextAnimation = 14.0;

  void changeSizeText() {
    sizeTextAnimation = 20.0;
    emit(ShowOrHideHomeViewContainer());
  }
}
