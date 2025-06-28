import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_keyboard.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_state.dart';
import 'package:flutter_bizpage/pages/main/a_intro/arrow.dart';
import 'package:flutter_bizpage/pages/main/a_intro/middle.dart';
import 'package:flutter_bizpage/pages/main/a_intro/slide_indicators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Intro extends ConsumerStatefulWidget {
  const Intro({
    required this.onActionTap,
    super.key,
  });

  final void Function(int section) onActionTap;

  @override
  ConsumerState<Intro> createState() => _IntroState();
}

class _IntroState extends ConsumerState<Intro> {
  late PageController _pageController;
  late RestartableTimer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = RestartableTimer(
      slideSwitchSecs,
      () => _switchSlide(_nextSlide),
    );
    // TODO(albert): when switching back to ListView
    // all items on a page need to handle their state properly
    // this guy disposes once the list is like on the 3rd section.
    //WidgetsBinding.instance!.addPostFrameCallback((_) {
    //  context.read(currentSlideProvider).state = 0;
    //});
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _switchSlide(int slide) => _pageController.animateToPage(
    slide,
    duration: slideAnimateMillis,
    curve: Curves.easeInOut,
  );

  int get _currentSlide => _pageController.page?.round() ?? 0;

  int get _prevSlide {
    final slide = _currentSlide - 1;
    return slide < 0 ? introData.length : slide;
  }

  int get _nextSlide {
    final slide = _currentSlide + 1;
    return slide == introData.length ? 0 : slide;
  }

  @override
  Widget build(BuildContext context) => Keyboard(
    onKeyPress: (keyType) {
      _switchSlide(keyType == KeyType.left ? _prevSlide : _nextSlide);
    },
    child: SizedBox(
      height: context.screenHeight,
      width: context.screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // disables the built in scroll indicator of the PageView
          NotificationListener(
            onNotification: (_) => true,
            child: PageView(
              controller: _pageController,
              onPageChanged: (slide) {
                _timer.reset();
                ref.read(currentSlideProvider.notifier).state = slide;
              },
              children: [
                ...introData.entries.map(
                  (entry) => DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/${entry.value.asset}.jpg'),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Middle(
                        entry.value,
                        onActionTap: () => widget.onActionTap(
                          actionButtonMappings[entry.key]!,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Arrow(
                Direction.backward,
                onPressed: () => _switchSlide(_prevSlide),
              ),
              Arrow(
                Direction.forward,
                onPressed: () => _switchSlide(_nextSlide),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            child: SlideIndicators(onTap: _switchSlide),
          ),
        ],
      ),
    ),
  );
}
