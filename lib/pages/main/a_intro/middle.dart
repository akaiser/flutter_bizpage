import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/pages/_shared/action_button.dart';
import 'package:flutter_bizpage/pages/_shared/formatted_text.dart';
import 'package:flutter_bizpage/pages/_shared/scalable_text.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';

class Middle extends StatelessWidget {
  const Middle(
    this.introData, {
    required this.onActionTap,
    Key? key,
  }) : super(key: key);

  final IntroData introData;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.appTextTheme.paragraph.copyWith(
      color: Colors.white,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ScalableText(
              introData.title,
              fontSizes: const [48, 38, 28, 26],
              textStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            FormattedText(
              text: introData.text,
              textStyle: textStyle.copyWith(height: 1.5),
            ),
          ],
        ),
        const SizedBox(height: 40),
        ActionButton(
          introData.actionText,
          onTap: onActionTap,
        ),
      ],
    );
  }
}
