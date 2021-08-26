import 'package:flutter_bizpage/_utils/device.dart';
import 'package:flutter_bizpage/_utils/system.dart';

class Environment {
  Environment._();

  static late bool isDesktopOrWeb;
  static late bool isPhysicalDevice;

  static Future<void> init() async {
    isDesktopOrWeb = System.isDesktop || System.isWeb;

    final device = isDesktopOrWeb ? DesktopDevice() : MobileDevice();
    isPhysicalDevice = await device.isPhysicalDevice;
  }
}
