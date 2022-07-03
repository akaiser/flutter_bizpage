import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_extensions/iterable.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_layout.dart';
import 'package:flutter_bizpage/pages/main/b_about/_data.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  static const double _itemSeparatorSize = 30;

  @override
  Widget build(BuildContext context) {
    final cards = sectionData.map<Widget>(_Card.new).unmodifiable;

    return ResponsiveLayout(
      medium: (_) => Row(
        children: [
          ...cards
              .map<Widget>((card) => Expanded(child: card))
              .joinEx(const SizedBox(width: _itemSeparatorSize))
        ],
      ),
      small: (_) => Column(
        children: cards
            .joinEx(const SizedBox(height: _itemSeparatorSize))
            .unmodifiable,
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.sectionData, {super.key});

  final SectionData sectionData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Image.asset('images/${sectionData.asset}.jpg'),
          const SizedBox(height: 20),
          Column(
            children: [
              Text(
                sectionData.title,
                style: context.appTextTheme.h3,
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    sectionData.description,
                    style: context.appTextTheme.paragraph.copyWith(height: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
