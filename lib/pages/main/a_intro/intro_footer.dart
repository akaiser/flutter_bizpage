import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_util/list.dart';
import 'package:flutter_bizpage/pages/_shared/_theme.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_layout.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroFooter extends StatelessWidget {
  const IntroFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: const [
            _Co2Text(),
            SizedBox(height: 10),
            _Logos(),
          ],
        ),
      ),
    );
  }
}

class _Co2Text extends StatelessWidget {
  const _Co2Text({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      co2Text,
      textAlign: TextAlign.justify,
      style: AppTextTheme.of(context).small.copyWith(color: Colors.white),
    );
  }
}

class _Logos extends StatelessWidget {
  const _Logos({Key? key}) : super(key: key);

  List<Widget> get _logos => [...logoData.map((item) => _Logo(item))];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      large: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _logos,
      ),
      medium: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ..._logos.chunks(2).map(
                (chunk) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: chunk,
                ),
              ),
        ],
      ),
      small: (_) => Column(children: _logos),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo(this.logoData, {Key? key}) : super(key: key);

  final LogoData logoData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async => launch(logoData.link),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset(
          'images/${logoData.asset}.png',
          height: logoData.height,
        ),
      ),
    );
  }
}
