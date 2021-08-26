import 'package:flutter/widgets.dart';

class FadeIn extends StatefulWidget {
  const FadeIn({
    required this.child,
    this.milliseconds = 500,
    Key? key,
  }) : super(key: key);

  final int milliseconds;
  final Widget child;

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.milliseconds),
    );
  }

  @override
  void didChangeDependencies() {
    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller.drive(CurveTween(curve: Curves.easeIn)),
      child: widget.child,
    );
  }
}
