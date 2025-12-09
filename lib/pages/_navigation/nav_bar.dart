import 'package:flutter/material.dart';
import 'package:flutter_bizpage/_app_state.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_extensions/iterable.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/pages/_navigation/_data.dart';
import 'package:flutter_bizpage/pages/_shared/breakpoint.dart';
import 'package:flutter_bizpage/pages/_shared/hover_region.dart';

// TODO(albert): make it 30 on landscape mobile
const double navigationBarHeight = 68;
const _navigationBarHorizontalPadding = EdgeInsets.symmetric(horizontal: 20);

bool isFullNavigationBar(double screenWidth) =>
    resolveBreakpoint(screenWidth) != Breakpoint.small;

class NavBar extends StatelessWidget {
  const NavBar({
    required this.onNavTap,
    super.key,
  });

  final void Function(int section) onNavTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: navigationBarHeight,
    child: isFullNavigationBar(context.screenWidth)
        ? _Full(onNavTap)
        : _Compact(onNavTap),
  );
}

class _Full extends StatelessWidget {
  const _Full(this.onNavTap);

  final void Function(int section) onNavTap;

  static const _minNavWidthForLogo = 850;

  @override
  Widget build(BuildContext context) => AppStateSelector<bool>(
    selector: (_, appState) => appState.isAtTop,
    builder: (context, isAtTop, child) => AnimatedContainer(
      color: isAtTop ? Colors.transparent : statusBarColor,
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
              style: context.tt.medium?.copyWith(
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

class _FullMenuItem extends StatelessWidget {
  const _FullMenuItem(this.entry, this.onNavTap);

  final MapEntry<int, NavigationItem> entry;
  final void Function(int section) onNavTap;

  @override
  Widget build(BuildContext context) => TextButton(
    style: ButtonStyle(
      overlayColor: WidgetStateColor.resolveWith(
        (_) => Colors.transparent,
      ),
    ),
    onPressed: () => onNavTap(entry.key),
    child: HoverRegion(
      builder: (context, isHovering, child) => AppStateSelector<int>(
        selector: (_, appState) => appState.currentSection,
        builder: (context, currentSection, child) => AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: context.tt.medium!.copyWith(
            fontWeight: FontWeight.w700,
            color: entry.key == currentSection || isHovering
                ? sgsRedColor
                : Colors.white,
          ),
          child: child!,
        ),
        child: child,
      ),
      child: Text(entry.value.text.toUpperCase()),
    ),
  );
}

class _Compact extends StatelessWidget {
  const _Compact(this.onNavTap);

  final void Function(int section) onNavTap;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: _navigationBarHorizontalPadding,
      child: AppStateSelector<bool>(
        selector: (_, appState) => appState.isIntroVisible,
        builder: (context, isIntroVisible, child) => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: isIntroVisible
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

class _CompactMenuItem extends StatelessWidget {
  const _CompactMenuItem(this.entry);

  final MapEntry<int, NavigationItem> entry;

  @override
  Widget build(BuildContext context) => AppStateSelector<int>(
    selector: (_, appState) => appState.currentSection,
    builder: (context, currentSection, child) => Text(
      entry.value.text.toUpperCase(),
      style: context.tt.medium?.copyWith(
        fontWeight: FontWeight.w700,
        color: currentSection != entry.key ? Colors.black : sgsRedColor,
      ),
    ),
  );
}
