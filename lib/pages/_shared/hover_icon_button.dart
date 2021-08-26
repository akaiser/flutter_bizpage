import 'package:flutter/material.dart';
import 'package:flutter_bizpage/pages/_shared/hover_widget.dart';

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
  final int iconSize;

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      builder: (context, isHovering) => IconButton(
        //splashColor: Colors.transparent,
        //splashRadius: 1,
        onPressed: onPressed,
        padding: padding,
        color: isHovering ? Colors.white : Colors.grey[400],
        iconSize: 36,
        icon: icon,
      ),
    );
  }
}
