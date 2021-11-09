import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_extensions/list.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/pages/_navigation/_state.dart';
import 'package:flutter_bizpage/pages/_navigation/navigation_bar.dart';
import 'package:flutter_bizpage/pages/_shared/measure_size.dart';
import 'package:flutter_bizpage/pages/_shared/responsive_container.dart';
import 'package:flutter_bizpage/pages/_shared/scalable_text.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_state.dart';
import 'package:flutter_bizpage/pages/main/a_intro/intro.dart';
import 'package:flutter_bizpage/pages/main/a_intro/intro_footer.dart';
import 'package:flutter_bizpage/pages/main/b_about/about_section.dart';
import 'package:flutter_bizpage/pages/main/c_services/services_section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _animateToOffset(double offset) => _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
      );

  @override
  Widget build(BuildContext context) {
    final _isFullNavigationBar = isFullNavigationBar(context.screenWidth);

    final _atTopProvider = ref.read(atTopProvider.state);
    final _introVisibleProvider = ref.read(introVisibleProvider.state);
    final _currentSectionProvider = ref.read(currentSectionProvider.state);

    double reduce(int section) => _SectionHeights.entries
        .take(section)
        .map((entry) => entry.value)
        .reduce((a, b) => a + b);

    void updateSection(int section) {
      if (_currentSectionProvider.state != section) {
        _currentSectionProvider.state = section;
      }
    }

    double navBarOffset() => _isFullNavigationBar
        ? navigationBarHeight + context.mediaQueryData.padding.top
        : 0;

    void animateToSection(int section) => section == 0
        ? _animateToOffset(0)
        : _animateToOffset(reduce(section + 1) - navBarOffset());

    int identifySection(int startSection, double currentOffset) =>
        currentOffset >= reduce(startSection)
            ? startSection - 1
            : startSection == 1
                ? 0
                : identifySection(startSection - 1, currentOffset);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: statusBarColor),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                ref.read(currentSlideProvider.state).state = 0;
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute<MainPage>(
                    builder: (_) => const MainPage(),
                  ),
                );
              },
              child: Scrollbar(
                notificationPredicate: (notification) {
                  if (notification.metrics.axis == Axis.vertical) {
                    final metrics = notification.metrics;
                    final currentOffset = metrics.pixels;
                    final isAtTop = metrics.atEdge && currentOffset == 0;
                    if (_atTopProvider.state != isAtTop) {
                      _atTopProvider.state = isAtTop;
                    }

                    final isIntroVisible = currentOffset < context.screenHeight;
                    if (_introVisibleProvider.state != isIntroVisible) {
                      _introVisibleProvider.state = isIntroVisible;
                    }

                    final calculatedOffset = currentOffset + navBarOffset();
                    updateSection(identifySection(6, calculatedOffset));
                  }
                  return true;
                },
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...[
                        Intro(onActionTap: animateToSection),
                        const IntroFooter(),
                        const AboutSection(),
                        const ServicesSection(),
                        const _DummySection(
                          height: 560,
                          color: Colors.green,
                          text: 'FAHRZEUGANGEBOT',
                        ),
                        const _DummySection(
                          height: 450,
                          color: Colors.red,
                          text: 'DAS TEAM',
                        ),
                        const _DummySection(
                          height: 440,
                          color: Colors.blue,
                          text: 'KONTAKT',
                        ),
                      ].mapIndexed(
                        (index, element) => MeasureSize(
                          onChange: (height) => _SectionHeights.set(
                            index,
                            height,
                          ),
                          child: element,
                        ),
                      ),
                      const _DummySection(
                        height: 400,
                        color: Colors.black,
                        text: 'FOOTER',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: SafeArea(
                left: false,
                right: false,
                child: NavigationBar(onNavTap: animateToSection),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeights {
  _SectionHeights._();

  static final _heights = <int, double>{};

  static void set(int section, double value) => _heights[section] = value;

  static Iterable<MapEntry<int, double>> get entries => _heights.entries;
}

class _DummySection extends StatelessWidget {
  const _DummySection({
    required this.height,
    required this.color,
    required this.text,
    Key? key,
  }) : super(key: key);

  final double height;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ColoredBox(
        color: color,
        child: ResponsiveContainer(
          child: Column(
            children: [
              SizedBox(
                height: !Environment.isDesktopOrWeb &&
                        !isFullNavigationBar(context.screenWidth)
                    ? 29
                    : 10,
              ),
              ScalableText(
                text.toUpperCase(),
                fontSizes: const [32, 28, 26, 24],
                textStyle: context.appTextTheme.paragraph.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
