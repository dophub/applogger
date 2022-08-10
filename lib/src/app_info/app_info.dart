import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart' as package;

class AppInfo {
  static AppInfo? _instance;

  static AppInfo get instance => _instance ??= AppInfo();

  Map? packageInfoMap;
  Map? deviceInfoPluginMap;

  Future<Map> getPackageInfo() async {
    try {
      if (packageInfoMap != null) return packageInfoMap!;
      final info = await package.PackageInfo.fromPlatform();
      var replaceMap = {
        r' ': '_',
        'ç|Ç': 'c',
        'ğ|Ğ': 'g',
        'ş|Ş': 's',
        'ü|Ü': 'u',
        'ı|İ': 'i',
        'ö|Ö': 'o',
        r'[^a-zA-Z0-9_]':''
      };
      String name = info.appName;
      replaceMap.forEach((key, value) => name = name.replaceAll(RegExp(key), value));
      packageInfoMap = {
        "appName": name,
        "version": info.version,
        "buildNumber": info.buildNumber,
        "packageName": info.packageName,
      };
      return packageInfoMap!;
    } catch (e) {
      return {};
    }
  }

  Future<Map> getDeviceInfo() async {
    try {
      if (deviceInfoPluginMap != null) return deviceInfoPluginMap!;
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        deviceInfoPluginMap = (await deviceInfo.iosInfo).toMap();
      } else {
        deviceInfoPluginMap = (await deviceInfo.androidInfo).toMap();
        deviceInfoPluginMap?.remove('systemFeatures');
      }
      return deviceInfoPluginMap!;
    } catch (e) {
      return {};
    }
  }
}
