import 'package:flutter_bizpage/_utils/system.dart';

abstract interface class Environment {
  Environment._();

  static late bool isDesktopOrWeb;

  static void init() {
    isDesktopOrWeb = System.isDesktop || System.isWeb;
  }
}
