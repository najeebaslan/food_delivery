import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  int indexIndicator = 0;
  void nextIndicator({int? index}) async {
    if (index != null) {
      indexIndicator = index;
    } else {
      if (indexIndicator == 2) return;
      indexIndicator = indexIndicator == 2 ? 0 : indexIndicator + 1;
    }
    emit(NextIndicatorOnboarding(indexIndicator));
  }
}
