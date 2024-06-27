import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  ValueNotifier<double> animationTransition = ValueNotifier(0.0);

  bool showContainer = false;
  void showOrHideHomeViewContainer() {
    showContainer = !showContainer;
    emit(ShowOrHideHomeViewContainer());
  }
}
