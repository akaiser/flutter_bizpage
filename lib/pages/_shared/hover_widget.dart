import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  const HoverWidget({
    required this.builder,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext context, bool isHovering) builder;

  @override
  _HoverWidgetState createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: widget.builder(context, _isHovering),
    );
  }
}
