part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class NextIndicatorOnboarding extends OnboardingState {
  final int indexIndicator;
  NextIndicatorOnboarding(this.indexIndicator);
}

final class InitAnimationOnboarding extends OnboardingState {}
final class CompletedFirstAnimationOnboarding extends OnboardingState {}
// final class ResetOpacityCircleIndicatorOnboarding extends OnboardingState {
//   final double opacityCircleIndicator;
//   ResetOpacityCircleIndicatorOnboarding(this.opacityCircleIndicator);
// }
