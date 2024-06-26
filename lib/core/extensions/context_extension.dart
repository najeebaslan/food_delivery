import 'package:flutter/material.dart';

extension ContextExtension<T> on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get mediaQuery => MediaQuery.sizeOf(this);
  double get height => mediaQuery.height;
  double get width => mediaQuery.width;
  bool get isSmallDevice => height < 600 ? true : false;
}
