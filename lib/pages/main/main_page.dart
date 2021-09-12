import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_extensions/list.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/pages/_navigation/_state.dart';
import 'package:flutter_bizpage/pages/_navigation/navigation_bar.dart';
import 'package:flutter_bizpage/pages/_shared/measure_size.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_state.dart';
import 'package:flutter_bizpage/pages/main/a_intro/intro.dart';
import 'package:flutter_bizpage/pages/main/a_intro/intro_footer.dart';
import 'package:flutter_bizpage/pages/main/b_about/about_section.dart';
import 'package:flutter_bizpage/pages/main/c_services/services_section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

    final _atTopProvider = context.read(atTopProvider);
    final _introVisibleProvider = context.read(introVisibleProvider);
    final _currentSectionProvider = context.read(currentSectionProvider);

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
                context.read(currentSlideProvider).state = 0;
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
                        Container(
                          height: 560,
                          color: Colors.lightGreenAccent,
                          child: const Text('FAHRZEUGANGEBOT'),
                        ),
                        Container(
                          height: 450,
                          color: Colors.redAccent[100],
                          child: const Text('DAS TEAM'),
                        ),
                        Container(
                          height: 440,
                          color: Colors.blueAccent[100],
                          child: const Text('KONTAKT'),
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
                      const SizedBox(
                        height: 800,
                        child: Text('ELSE'),
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
