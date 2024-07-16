part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}
final class ProductDetailsVisible extends ProductDetailsState {}
final class ProductSelected extends ProductDetailsState {}
final class ProductDetailsSizeChanged extends ProductDetailsState {}
final class ChangeStateAnimation extends ProductDetailsState {}
