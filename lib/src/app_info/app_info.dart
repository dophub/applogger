import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart' as package;

class AppInfo {
  static AppInfo? _instance;

  static AppInfo get instance => _instance ??= AppInfo();

  Future<Map> getPackageInfo() async {
    try {
      final info = await package.PackageInfo.fromPlatform();
      return {
        "appName": info.appName.replaceAll(RegExp(",|!|[+]|[~]|[#]|[=]|[?]"), "").replaceAll(RegExp(r'\s\s'), ' '),
        "version": info.version,
        "buildNumber": info.buildNumber,
        "packageName": info.packageName,
      };
    } catch (e) {
      return {};
    }
  }

  Future<Map> getDeviceInfo() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        return (await deviceInfo.iosInfo).toMap();
      } else {
        return (await deviceInfo.androidInfo).toMap();
      }
    } catch (e) {
      return {};
    }
  }
}
