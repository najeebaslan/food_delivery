part of 'home_cubit.dart';

class HomeState {}

class HomeInitial extends HomeState {}

// class EnableOrDisableRotateRedCircle extends HomeState {}
// class ChangeRedCircleColor extends HomeState {}
class NavigateToView extends HomeState {
  final NavigateTo navigateTo;
  NavigateToView(this.navigateTo);
}
class ChangeRedCircleColor extends HomeState {}
