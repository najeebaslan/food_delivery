import 'package:flutter/material.dart';

extension ContextExtension<T> on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
