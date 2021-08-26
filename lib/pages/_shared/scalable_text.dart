import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/_extensions/context.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';

class ScalableText extends StatelessWidget {
  const ScalableText(
    this.text, {
    required this.fontSizes,
    required this.textStyle,
    this.textAlign = TextAlign.center,
    Key? key,
  })  : assert(fontSizes.length == 4),
        super(key: key);

  final String text;

  // huge | large | medium | small
  final List<double> fontSizes;
  final TextStyle textStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle.copyWith(fontSize: _resolveFontSize(context)),
    );
  }

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
