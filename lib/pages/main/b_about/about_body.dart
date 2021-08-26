import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/list.dart';
import 'package:flutter_bizpage/pages/_shared/_theme.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_layout.dart';
import 'package:flutter_bizpage/pages/main/b_about/_data.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({Key? key}) : super(key: key);

  static const double _itemSeparatorSize = 30;

  List<Widget> get _cards => [...sectionData.map((item) => _Card(item))];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      medium: (_) => Row(
        children: [
          ..._cards
              .map<Widget>((card) => Expanded(child: card))
              .joinEx(const SizedBox(width: _itemSeparatorSize))
        ],
      ),
      small: (_) => Column(
        children: [
          ..._cards.joinEx(const SizedBox(height: _itemSeparatorSize)),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.sectionData, {Key? key}) : super(key: key);

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
                style: AppTextTheme.of(context).h3,
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  sectionData.description,
                  textAlign: TextAlign.start,
                  style: AppTextTheme.of(context).paragraph.copyWith(
                        height: 1.5,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
