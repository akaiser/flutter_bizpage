import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_extensions/list.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_layout.dart';
import 'package:flutter_bizpage/pages/main/c_services/_data.dart';

class ServicesBody extends StatelessWidget {
  const ServicesBody({Key? key}) : super(key: key);

  static const double _itemSeparatorSize = 30;

  @override
  Widget build(BuildContext context) {
    final services = sectionData.map<Widget>((it) => _Service(it)).unmodifiable;

    return ResponsiveLayout(
      large: (_) => Row(
        children: [
          ...services
              .map<Widget>((item) => Expanded(child: item))
              .joinEx(const SizedBox(width: _itemSeparatorSize)),
        ],
      ),
      medium: (_) => Column(
        // TODO(albert): more stuff here
        children: [
          ...services
              .chunks(2)
              .map<Widget>(
                (chunk) => Row(
                  children: [
                    ...chunk
                        .map<Widget>((item) => Expanded(child: item))
                        .joinEx(const SizedBox(width: _itemSeparatorSize)),
                  ],
                ),
              )
              .joinEx(const SizedBox(height: _itemSeparatorSize)),
        ],
      ),
      small: (_) => Column(
        children: services
            .joinEx(const SizedBox(height: _itemSeparatorSize))
            .unmodifiable,
      ),
    );
  }
}

class _Service extends StatelessWidget {
  const _Service(this.sectionData, {Key? key}) : super(key: key);

  final SectionData sectionData;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.appTextTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              sectionData.iconData,
              color: sgsRed,
              size: 36,
            ),
            const SizedBox(width: 14),
            Text(sectionData.title, style: textTheme.h3),
          ],
        ),
        const SizedBox(height: 6),
        ...sectionData.items.map(
          (item) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Environment.isDesktopOrWeb ? 0 : 6,
                  right: 2,
                ),
                child: const Icon(
                  Icons.arrow_right,
                  color: Colors.black38,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: textTheme.paragraph.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
