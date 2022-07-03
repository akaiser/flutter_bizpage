import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SlideIndicators extends ConsumerWidget {
  const SlideIndicators({
    super.key,
    required this.onTap,
  });

  final void Function(int introId) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSlide = ref.watch(currentSlideProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...introData.entries.map(
          (entry) => _SlideIndicator(
            isSelected: currentSlide == entry.key,
            onTap: () => onTap(entry.key),
          ),
        ),
      ],
    );
  }
}

class _SlideIndicator extends StatelessWidget {
  const _SlideIndicator({
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 30,
      child: RawMaterialButton(
        splashColor: Colors.transparent,
        onPressed: isSelected ? null : onTap,
        child: SizedBox(
          width: 30,
          height: 3,
          child: ColoredBox(
            color: isSelected ? Colors.white : inactiveButtonColor,
          ),
        ),
      ),
    );
  }
}
