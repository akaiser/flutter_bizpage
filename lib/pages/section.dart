import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/context.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/pages/_navigation/legacy_bar.dart';
import 'package:flutter_bizpage/pages/_shared/_theme.dart';
import 'package:flutter_bizpage/pages/_shared/formatted_text.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_container.dart';
import 'package:flutter_bizpage/pages/_shared/scalable_text.dart';
import 'package:flutter_bizpage/prefs.dart';

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
    final textStyle = AppTextTheme.of(context).paragraph;
    final _isFullNavigationBar = isFullNavigationBar(context.screenWidth);
    return ResponsiveContainer(
      child: Column(
        children: [
          if (!Environment.isDesktopOrWeb && !_isFullNavigationBar)
            const SizedBox(height: 19),
          const SizedBox(height: 10),
          ScalableText(
            title.toUpperCase(),
            fontSizes: const [32, 28, 26, 24],
            textStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const ColoredBox(
            color: sgsRed,
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
