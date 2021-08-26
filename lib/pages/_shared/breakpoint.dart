import 'package:flutter/widgets.dart';

enum Breakpoint {
  huge,
  large,
  medium,
  small,
}

Breakpoint resolveBreakpoint(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width > 1199
      ? Breakpoint.huge
      : width > 991
          ? Breakpoint.large
          : width > 767
              ? Breakpoint.medium
              : Breakpoint.small;
}

double resolveMaxWidth(BuildContext context) {
  final breakpoint = resolveBreakpoint(context);
  return breakpoint == Breakpoint.huge
      ? 1140
      : breakpoint == Breakpoint.large
          ? 960
          : breakpoint == Breakpoint.medium
              ? 720
              : 540;
}
