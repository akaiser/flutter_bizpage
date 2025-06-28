import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MeasureSize extends SingleChildRenderObjectWidget {
  const MeasureSize({
    required this.onChange,
    required Widget super.child,
    super.key,
  });

  final void Function(double height) onChange;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _MeasureSizeRenderObject(onChange);
}

class _MeasureSizeRenderObject extends RenderProxyBox {
  _MeasureSizeRenderObject(this.onChange);

  Size oldSize = Size.zero;
  final void Function(double height) onChange;

  @override
  void performLayout() {
    super.performLayout();

    final _child = child;
    if (_child != null) {
      final newSize = _child.size;
      if (oldSize == newSize) {
        return;
      }

      oldSize = newSize;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onChange(newSize.height);
      });
    }
  }
}
