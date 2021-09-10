import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/pages/_shared/hover_widget.dart';
import 'package:flutter_bizpage/prefs.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
    this.text, {
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      builder: (context, isHovering) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isHovering ? sgsRed : Colors.transparent,
          border: Border.all(
            width: 2,
            color: isHovering ? sgsRed : Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: RawMaterialButton(
          onPressed: onTap,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: context.appTextTheme.paragraph.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
