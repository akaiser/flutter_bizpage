import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: SizedBox(
        width: resolveMaxWidth(context.screenWidth),
        child: child,
      ),
    ),
  );
}
