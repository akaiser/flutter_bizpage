import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SlideIndicators extends StatelessWidget {
  const SlideIndicators({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final void Function(int introId) onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final currentSlide = watch(currentSlideProvider).state;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...introData.entries.map(
              (entry) => _SlideIndicator(
                selected: currentSlide == entry.key,
                onTap: () => onTap(entry.key),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SlideIndicator extends StatelessWidget {
  const _SlideIndicator({
    required this.selected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 30,
      child: RawMaterialButton(
        splashColor: Colors.transparent,
        onPressed: selected ? null : onTap,
        child: SizedBox(
          width: 30,
          height: 3,
          child: ColoredBox(
            color: selected ? Colors.white : inactiveButtonColor,
          ),
        ),
      ),
    );
  }
}
