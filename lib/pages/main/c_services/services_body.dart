import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bizpage/_extensions/list.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/pages/_shared/_theme.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_layout.dart';
import 'package:flutter_bizpage/pages/main/c_services/_data.dart';
import 'package:flutter_bizpage/prefs.dart';

class ServicesBody extends StatelessWidget {
  const ServicesBody({Key? key}) : super(key: key);

  static const double _itemSeparatorSize = 30;

  List<Widget> get _services => [...sectionData.map((item) => _Service(item))];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      large: (_) => Row(
        children: [
          ..._services
              .map<Widget>((item) => Expanded(child: item))
              .joinEx(const SizedBox(width: _itemSeparatorSize)),
        ],
      ),
      medium: (_) => Column(
        // TODO(albert): more stuff here
        children: [
          ..._services
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
        children: [
          ..._services.joinEx(const SizedBox(height: _itemSeparatorSize)),
        ],
      ),
    );
  }
}

class _Service extends StatelessWidget {
  const _Service(this.sectionData, {Key? key}) : super(key: key);

  final SectionData sectionData;

  @override
  Widget build(BuildContext context) {
    final theme = AppTextTheme.of(context);
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
            Text(sectionData.title, style: theme.h3),
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
                  style: theme.paragraph.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
