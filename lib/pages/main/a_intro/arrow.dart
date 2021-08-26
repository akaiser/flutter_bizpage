import 'package:flutter/material.dart';
import 'package:flutter_bizpage/pages/_shared/hover_icon_button.dart';

enum Direction {
  forward,
  backward,
}

class Arrow extends StatelessWidget {
  const Arrow(
    this.direction, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Direction direction;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return HoverIconButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(20),
      icon: Icon(
        direction == Direction.backward
            ? Icons.arrow_back_ios_outlined
            : Icons.arrow_forward_ios_outlined,
      ),
    );
  }
}
