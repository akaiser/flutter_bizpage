import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/pages/_shared/hover_region.dart';

class HoverIconButton extends StatelessWidget {
  const HoverIconButton({
    required this.onPressed,
    required this.padding,
    required this.icon,
    this.iconSize = 36,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final Widget icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      builder: (context, isHovering, child) {
        return IconButton(
          onPressed: onPressed,
          padding: padding,
          color: isHovering ? Colors.white : inactiveButtonColor,
          icon: child!,
          iconSize: iconSize,
        );
      },
      child: icon,
    );
  }
}
