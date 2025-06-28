import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';

class ScalableText extends StatelessWidget {
  const ScalableText(
    this.text, {
    required this.fontSizes,
    required this.textStyle,
    this.textAlign = TextAlign.center,
    super.key,
  }) : assert(
         fontSizes.length == 4,
         'one needs to provide four font sizes',
       );

  final String text;

  // huge | large | medium | small
  final List<double> fontSizes;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: textAlign,
    style: textStyle?.copyWith(fontSize: _resolveFontSize(context)),
  );

  double _resolveFontSize(BuildContext context) {
    switch (resolveBreakpoint(context.screenWidth)) {
      case Breakpoint.huge:
        return fontSizes[0];
      case Breakpoint.large:
        return fontSizes[1];
      case Breakpoint.medium:
        return fontSizes[2];
      case Breakpoint.small:
        return fontSizes[3];
    }
  }
}
