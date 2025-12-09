import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_app_state.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';

class SlideIndicators extends StatelessWidget {
  const SlideIndicators({
    required this.onTap,
    super.key,
  });

  final void Function(int introId) onTap;

  @override
  Widget build(BuildContext context) => AppStateSelector<int>(
    selector: (_, appState) => appState.currentSlide,
    builder: (context, currentSlide, _) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...introData.entries.map(
          (entry) => _SlideIndicator(
            isSelected: currentSlide == entry.key,
            onTap: () => onTap(entry.key),
          ),
        ),
      ],
    ),
  );
}

class _SlideIndicator extends StatelessWidget {
  const _SlideIndicator({
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
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
