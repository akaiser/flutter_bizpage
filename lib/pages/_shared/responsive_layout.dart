import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.small,
    this.huge,
    this.large,
    this.medium,
    super.key,
  });

  final WidgetBuilder? huge;
  final WidgetBuilder? large;
  final WidgetBuilder? medium;
  final WidgetBuilder small;

  @override
  Widget build(BuildContext context) {
    final breakpoint = resolveBreakpoint(context.screenWidth);
    return breakpoint == Breakpoint.huge
        ? _HugeFallback(
            huge: huge,
            large: large,
            medium: medium,
            small: small,
          )
        : breakpoint == Breakpoint.large
        ? _LargeFallback(
            large: large,
            medium: medium,
            small: small,
          )
        : breakpoint == Breakpoint.medium
        ? _MediumFallback(
            medium: medium,
            small: small,
          )
        : small(context);
  }
}

class _HugeFallback extends StatelessWidget {
  const _HugeFallback({
    required this.huge,
    required this.large,
    required this.medium,
    required this.small,
  });

  final WidgetBuilder? huge;
  final WidgetBuilder? large;
  final WidgetBuilder? medium;
  final WidgetBuilder small;

  @override
  Widget build(BuildContext context) {
    final _huge = huge;
    return _huge != null
        ? _huge(context)
        : _LargeFallback(large: large, medium: medium, small: small);
  }
}

class _LargeFallback extends StatelessWidget {
  const _LargeFallback({
    required this.large,
    required this.medium,
    required this.small,
  });

  final WidgetBuilder? large;
  final WidgetBuilder? medium;
  final WidgetBuilder small;

  @override
  Widget build(BuildContext context) {
    final _large = large;
    return _large != null
        ? _large(context)
        : _MediumFallback(medium: medium, small: small);
  }
}

class _MediumFallback extends StatelessWidget {
  const _MediumFallback({
    required this.medium,
    required this.small,
  });

  final WidgetBuilder? medium;
  final WidgetBuilder small;

  @override
  Widget build(BuildContext context) {
    final _medium = medium;
    return _medium != null ? _medium(context) : small(context);
  }
}
