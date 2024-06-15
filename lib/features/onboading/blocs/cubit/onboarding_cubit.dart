import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  int indexIndicator = 0;
  double opacityText = 1.0;
  void nextIndicator() async {
    indexIndicator == 0 ? opacityText = 1 : opacityText = 0;
    if (indexIndicator == 2) {
      return;
    } else {
      opacityText = 1;

      indexIndicator = indexIndicator == 2 ? 0 : indexIndicator + 1;
      emit(NextIndicatorOnboarding(indexIndicator));

      changeOpacity();
    }
  }

  changeOpacity() {
    Future.delayed(Duration(milliseconds: 500), () {
      opacityText = 1.0;
      emit(NextIndicatorOnboarding(indexIndicator));
    });
  }
}
