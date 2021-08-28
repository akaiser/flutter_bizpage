import 'package:flutter/material.dart';
import 'package:flutter_bizpage/pages/_shared/_theme.dart';

extension BuildContextEx on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  double get screenHeight => mediaQueryData.size.height;

  double get screenWidth => mediaQueryData.size.width;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppTextTheme get appTextTheme => AppTextTheme.of(textTheme);
}
