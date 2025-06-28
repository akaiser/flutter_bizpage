import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_extensions/iterable.dart';
import 'package:flutter_bizpage/_extensions/list.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_layout.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroFooter extends StatelessWidget {
  const IntroFooter({super.key});

  @override
  Widget build(BuildContext context) => const ColoredBox(
    color: Colors.black,
    child: Padding(
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          _Co2Text(),
          SizedBox(height: 10),
          _Logos(),
        ],
      ),
    ),
  );
}

class _Co2Text extends StatelessWidget {
  const _Co2Text();

  @override
  Widget build(BuildContext context) => Text(
    co2Text,
    textAlign: TextAlign.justify,
    style: context.tt.small?.copyWith(color: Colors.white),
  );
}

class _Logos extends StatelessWidget {
  const _Logos();

  @override
  Widget build(BuildContext context) {
    final logos = logoData.map(_Logo.new).unmodifiable;

    return ResponsiveLayout(
      large: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: logos,
      ),
      medium: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...logos
              .chunks(2)
              .map(
                (chunk) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: chunk,
                ),
              ),
        ],
      ),
      small: (_) => Column(children: logos),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo(this.logoData, {super.key});

  final LogoData logoData;

  @override
  Widget build(BuildContext context) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () => launchUrl(Uri.parse(logoData.link)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(
        'images/${logoData.asset}.png',
        height: logoData.height,
      ),
    ),
  );
}
