import 'package:flutter/widgets.dart';

class ClickableRegion extends MouseRegion {
  const ClickableRegion({
    super.key,
    super.onEnter,
    super.onExit,
    required Widget super.child,
  }) : super(cursor: SystemMouseCursors.click);
}
