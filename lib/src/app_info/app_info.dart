import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart' as package;

class AppInfo {
  static AppInfo? _instance;

  static AppInfo get instance => _instance ??= AppInfo();

  Future<Map> getPackageInfo() async {
    try {
      final info = await package.PackageInfo.fromPlatform();
      var replaceMap = {
        ',|!|[+]|[~]|[#]|[=]|[?]': '',
        r'\s\s': ' ',
        'ç|Ç': 'c',
        'ğ|Ğ': 'g',
        'ş|Ş': 's',
        'ü|Ü': 'u',
        'ı|İ': 'i',
        'ö|Ö': 'o',
      };
      String name = info.appName;
      replaceMap.forEach((key, value) => name = name.replaceAll(RegExp(key), value));
      return {
        "appName": name,
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
