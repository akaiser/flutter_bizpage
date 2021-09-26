import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_extensions/list.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/pages/_navigation/_data.dart';
import 'package:flutter_bizpage/pages/_navigation/_state.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';
import 'package:flutter_bizpage/pages/_shared/hover_widget.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO(albert): make it 30 on landscape mobile
const double navigationBarHeight = 68;
const _navigationBarHorizontalPadding = EdgeInsets.symmetric(horizontal: 20);

bool isFullNavigationBar(double screenWidth) {
  return resolveBreakpoint(screenWidth) != Breakpoint.small;
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    required this.onNavTap,
    Key? key,
  }) : super(key: key);

  final void Function(int section) onNavTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: navigationBarHeight,
      child: isFullNavigationBar(context.screenWidth)
          ? _Full(onNavTap)
          : _Compact(onNavTap),
    );
  }
}

class _Full extends StatelessWidget {
  const _Full(this.onNavTap, {Key? key}) : super(key: key);

  final void Function(int section) onNavTap;

  static const _minNavWidthForLogo = 850;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) => AnimatedContainer(
        color: watch(atTopProvider).state ? Colors.transparent : statusBarColor,
        duration: const Duration(milliseconds: 500),
        child: child,
      ),
      child: Padding(
        padding: _navigationBarHorizontalPadding,
        child: Row(
          children: [
            if (context.screenWidth > _minNavWidthForLogo)
              Text(
                'BizPage v${Environment.appVersion}',
                style: context.appTextTheme.medium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            const Spacer(),
            ...navigationData.entries
                .map<Widget>((entry) => _FullMenuItem(entry, onNavTap))
                .joinEx(const SizedBox(width: 10)),
          ],
        ),
      ),
    );
  }
}

class _FullMenuItem extends StatelessWidget {
  const _FullMenuItem(this.entry, this.onNavTap, {Key? key}) : super(key: key);

  final MapEntry<int, NavigationItem> entry;
  final void Function(int section) onNavTap;

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      builder: (context, isHovering) => TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(
            (_) => Colors.transparent,
          ),
        ),
        onPressed: () => onNavTap(entry.key),
        child: Consumer(
          builder: (context, watch, child) {
            final currentSection = watch(currentSectionProvider).state;
            final isRaised = entry.key == currentSection || isHovering;
            return AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: context.appTextTheme.medium.copyWith(
                fontWeight: FontWeight.w700,
                color: isRaised ? sgsRedColor : Colors.white,
              ),
              child: child!,
            );
          },
          child: Text(entry.value.text.toUpperCase()),
        ),
      ),
    );
  }
}

class _Compact extends StatelessWidget {
  const _Compact(this.onNavTap, {Key? key}) : super(key: key);

  final void Function(int section) onNavTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: _navigationBarHorizontalPadding,
        child: Consumer(
          builder: (context, watch, child) => AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: watch(introVisibleProvider).state
                  ? Colors.transparent
                  : const Color.fromRGBO(0, 0, 0, 0.6),
            ),
            child: child,
          ),
          child: PopupMenuButton<int>(
            color: Colors.white,
            elevation: 8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            tooltip: 'Menu',
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.menu,
              size: 36,
              color: Colors.white,
            ),
            onSelected: onNavTap,
            itemBuilder: (_) => [
              ...navigationData.entries.map(
                (entry) => PopupMenuItem<int>(
                  value: entry.key,
                  child: _CompactMenuItem(entry),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactMenuItem extends StatelessWidget {
  const _CompactMenuItem(this.entry, {Key? key}) : super(key: key);

  final MapEntry<int, NavigationItem> entry;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final fontStyle = context.appTextTheme.medium.copyWith(
          fontWeight: FontWeight.w700,
        );
        return Text(
          entry.value.text.toUpperCase(),
          style: fontStyle.copyWith(
            color: watch(currentSectionProvider).state != entry.key
                ? Colors.black
                : sgsRedColor,
          ),
        );
      },
    );
  }
}
