import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/list.dart';

final _emailLinkRegex =
    RegExp(r'[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,}\b([-a-zA-Z0-9\/]*)');

class FormattedText extends StatelessWidget {
  const FormattedText({
    required this.text,
    required this.textStyle,
    this.textAlign = TextAlign.center,
    Key? key,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: textStyle,
        children: _boldify(context, textStyle, text).unmodifiable,
      ),
      textAlign: textAlign,
    );
  }

  Iterable<TextSpan> _boldify(
    BuildContext context,
    TextStyle textStyle,
    String text,
  ) sync* {
    final parts = text.split('**');
    for (var i = 0; i < parts.length; i++) {
      final text = parts[i];
      if (i.isEven) {
        yield* _linkify(context, textStyle, text);
      } else {
        yield TextSpan(
          text: text,
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
        );
      }
    }
  }

  Iterable<TextSpan> _linkify(
    BuildContext context,
    TextStyle textStyle,
    String text,
  ) sync* {
    final nonMatches = text.split(_emailLinkRegex);
    final matches = _emailLinkRegex
        .allMatches(text)
        .map((match) => match.group(0))
        .unmodifiable;

    yield TextSpan(text: nonMatches[0], style: textStyle);
    for (var i = 1; i < nonMatches.length; i++) {
      final link = matches[i - 1];
      final trailing = nonMatches[i];
      yield TextSpan(
        text: link,
        style: textStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
        recognizer: _onLinkTapRecognizer(context, link!),
      );
      yield TextSpan(text: trailing, style: textStyle);
    }
  }

  GestureRecognizer _onLinkTapRecognizer(BuildContext context, String link) {
    return TapGestureRecognizer()
      ..onTap = () {
        Feedback.forTap(context);
        //context.injection.dispatch(
        //  NavigateToUrlAction(
        //    link.contains('@') ? 'mailto:$link' : 'https://$link',
        //  ),
        //);
      };
  }
}
