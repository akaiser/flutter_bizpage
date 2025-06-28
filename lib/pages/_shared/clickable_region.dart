import 'package:flutter/widgets.dart';

class ClickableRegion extends MouseRegion {
  const ClickableRegion({
    required Widget super.child,
    super.key,
    super.onEnter,
    super.onExit,
  }) : super(cursor: SystemMouseCursors.click);
}
