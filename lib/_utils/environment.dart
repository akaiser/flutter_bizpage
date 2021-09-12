import 'package:flutter_bizpage/_utils/system.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Environment {
  Environment._();

  static late String appVersion;
  static late bool isDesktopOrWeb;

  static Future<void> init() async {
    final packageInfo = PackageInfo.fromPlatform();
    appVersion = await packageInfo.then((value) => value.version);

    isDesktopOrWeb = System.isDesktop || System.isWeb;
  }
}
