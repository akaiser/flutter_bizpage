import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme(this._textTheme);

  final TextTheme _textTheme;

  TextStyle get h3 => const TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  TextStyle? get paragraph => _textTheme.titleLarge?.copyWith(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  TextStyle? get medium => _textTheme.titleLarge?.copyWith(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  TextStyle? get small => _textTheme.titleLarge?.copyWith(
    fontSize: 11,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
}
