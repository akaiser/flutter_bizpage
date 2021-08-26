import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/_extensions/context.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.small,
    this.huge,
    this.large,
    this.medium,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder? huge;
  final WidgetBuilder? large;
  final WidgetBuilder? medium;
  final WidgetBuilder small;

  Widget _hugeFallback(BuildContext context) =>
      huge != null ? huge!(context) : _largeFallback(context);

  Widget _largeFallback(BuildContext context) =>
      large != null ? large!(context) : _mediumFallback(context);

  Widget _mediumFallback(BuildContext context) =>
      medium != null ? medium!(context) : small(context);

  @override
  Widget build(BuildContext context) {
    final breakpoint = resolveBreakpoint(context.screenWidth);
    return breakpoint == Breakpoint.huge
        ? _hugeFallback(context)
        : breakpoint == Breakpoint.large
            ? _largeFallback(context)
            : breakpoint == Breakpoint.medium
                ? _mediumFallback(context)
                : small(context);
  }
}
