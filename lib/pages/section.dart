import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/pages/_navigation/nav_bar.dart';
import 'package:flutter_bizpage/pages/_shared/formatted_text.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_container.dart';
import 'package:flutter_bizpage/pages/_shared/scalable_text.dart';

class Section extends StatelessWidget {
  const Section({
    required this.title,
    required this.description,
    required this.body,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.appTextTheme.paragraph;
    return ResponsiveContainer(
      child: Column(
        children: [
          SizedBox(
            height: !Environment.isDesktopOrWeb &&
                    !isFullNavigationBar(context.screenWidth)
                ? 29
                : 10,
          ),
          ScalableText(
            title.toUpperCase(),
            fontSizes: const [32, 28, 26, 24],
            textStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const ColoredBox(
            color: sgsRedColor,
            child: SizedBox(height: 3, width: 60),
          ),
          const SizedBox(height: 16),
          FormattedText(
            text: description,
            textAlign: TextAlign.justify,
            textStyle: textStyle.copyWith(height: 1.5),
          ),
          const SizedBox(height: 30),
          body,
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
