import 'package:flutter_bizpage/_utils/system.dart';

class Environment {
  Environment._();

  static late bool isDesktopOrWeb;

  static Future<void> init() async {
    isDesktopOrWeb = System.isDesktop || System.isWeb;
  }
}
