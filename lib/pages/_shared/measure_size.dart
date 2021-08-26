import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MeasureSize extends SingleChildRenderObjectWidget {
  const MeasureSize({
    required this.onChange,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final void Function(double height) onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MeasureSizeRenderObject(onChange);
  }
}

class _MeasureSizeRenderObject extends RenderProxyBox {
  _MeasureSizeRenderObject(this.onChange);

  var oldSize = Size.zero;
  final void Function(double height) onChange;

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (oldSize == newSize) {
      return;
    }

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize.height);
    });
  }
}
