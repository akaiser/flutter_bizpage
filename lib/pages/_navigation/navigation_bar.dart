import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  NavigationBar({
    Key? key,
    double toolbarHeight = kToolbarHeight,
  })  : preferredSize = Size.fromHeight(toolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: const [
        Icon(
          Icons.menu,
          size: 36,
        ),
        SizedBox(width: 22),
      ],
    );
  }
}
