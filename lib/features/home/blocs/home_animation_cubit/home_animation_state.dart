part of 'home_animation_cubit.dart';

@immutable
sealed class HomeAnimationState {}

final class HomeAnimationInitial extends HomeAnimationState {}
final class ChangePageView extends HomeAnimationState {}