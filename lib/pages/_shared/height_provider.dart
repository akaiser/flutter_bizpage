import 'package:flutter/widgets.dart';

class HeightProvider extends StatefulWidget {
  const HeightProvider({
    required this.onChange,
    required this.child,
    Key? key,
  }) : super(key: key);

  final void Function(double height) onChange;
  final Widget child;

  @override
  _HeightProviderState createState() => _HeightProviderState();
}

class _HeightProviderState extends State<HeightProvider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.onChange(context.size!.height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
