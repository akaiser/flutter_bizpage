import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/pages/_shared/clickable_region.dart';

class HoverRegion extends StatefulWidget {
  const HoverRegion({
    required this.builder,
    required this.child,
    super.key,
  });

  final Widget Function(
    BuildContext context,
    // ignore: avoid_positional_boolean_parameters
    bool isHovering,
    Widget child,
  )
  builder;

  final Widget child;

  @override
  State<HoverRegion> createState() => _HoverRegionState();
}

class _HoverRegionState extends State<HoverRegion> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) => ClickableRegion(
    onEnter: (_) => setState(() => _isHovering = true),
    onExit: (_) => setState(() => _isHovering = false),
    child: widget.builder(context, _isHovering, widget.child),
  );
}
