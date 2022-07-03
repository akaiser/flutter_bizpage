import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: SizedBox(
          width: resolveMaxWidth(context.screenWidth),
          child: child,
        ),
      ),
    );
  }
}
