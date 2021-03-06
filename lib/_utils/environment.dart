import 'package:flutter_bizpage/_utils/system.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Environment {
  Environment._();

  static late String appVersion;
  static late bool isDesktopOrWeb;

  static Future<void> init() async {
    appVersion = await PackageInfo.fromPlatform().then((info) => info.version);
    isDesktopOrWeb = System.isDesktop || System.isWeb;
  }
}
