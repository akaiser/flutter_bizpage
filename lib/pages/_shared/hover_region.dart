import 'package:flutter/material.dart';

class HoverRegion extends StatefulWidget {
  const HoverRegion({
    required this.builder,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext context, bool isHovering) builder;

  @override
  _HoverRegionState createState() => _HoverRegionState();
}

class _HoverRegionState extends State<HoverRegion> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: widget.builder(context, _isHovering),
    );
  }
}
