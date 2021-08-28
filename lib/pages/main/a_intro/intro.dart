import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_keyboard.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_state.dart';
import 'package:flutter_bizpage/pages/main/a_intro/arrow.dart';
import 'package:flutter_bizpage/pages/main/a_intro/middle.dart';
import 'package:flutter_bizpage/pages/main/a_intro/slide_indicators.dart';
import 'package:flutter_bizpage/prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Intro extends StatefulWidget {
  const Intro({
    required this.onActionTap,
    Key? key,
  }) : super(key: key);

  final void Function(int section) onActionTap;

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final _pageController = PageController();
  late RestartableTimer _timer;

  @override
  void initState() {
    super.initState();
    _timer = RestartableTimer(
      slideTimerInterval,
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
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

  int get _currentSlide => _pageController.page!.round();

  int get _prevSlide {
    final slide = _currentSlide - 1;
    return slide < 0 ? introData.length : slide;
  }

  int get _nextSlide {
    final slide = _currentSlide + 1;
    return slide == introData.length ? 0 : slide;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Keyboard(
      onKeyPress: (keyType) {
        _switchSlide(keyType == KeyType.left ? _prevSlide : _nextSlide);
      },
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: NotificationListener<ScrollNotification>(
          // somehow this fixes something...
          onNotification: (_) => true,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (slide) {
                  _timer.reset();
                  context.read(currentSlideProvider).state = slide;
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
      ),
    );
  }
}