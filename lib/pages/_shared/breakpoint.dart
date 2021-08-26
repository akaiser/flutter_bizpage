enum Breakpoint {
  huge,
  large,
  medium,
  small,
}

Breakpoint resolveBreakpoint(double screenWidth) {
  return screenWidth > 1199
      ? Breakpoint.huge
      : screenWidth > 991
          ? Breakpoint.large
          : screenWidth > 767
              ? Breakpoint.medium
              : Breakpoint.small;
}

double resolveMaxWidth(double screenWidth) {
  final breakpoint = resolveBreakpoint(screenWidth);
  return breakpoint == Breakpoint.huge
      ? 1140
      : breakpoint == Breakpoint.large
          ? 960
          : breakpoint == Breakpoint.medium
              ? 720
              : 540;
}
