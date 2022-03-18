import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/pages/_shared/hover_region.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: HoverRegion(
        builder: (context, isHovering, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: isHovering ? sgsRedColor : Colors.transparent,
              border: Border.all(
                width: 2,
                color: isHovering ? sgsRedColor : Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: child!,
          );
        },
        child: _ActionButtonText(text),
      ),
    );
  }
}

class _ActionButtonText extends StatelessWidget {
  const _ActionButtonText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.appTextTheme.paragraph.copyWith(color: Colors.white),
      ),
    );
  }
}
