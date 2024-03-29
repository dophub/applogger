import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart' as package;

class AppInfo {
  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  late final String appName;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  late final String packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  late final String version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  late final String buildNumber;

  /// The build signature. Empty string on iOS, signing key signature (hex) on Android.
  late final String buildSignature;

  /// Unique UUID value identifying the current device.
  late final String deviceId;

  late final String? appVersion;

  late final String? device;

  late final String? model;

  late final bool? isPhysicalDevice;

  static AppInfo? _instance;

  AppInfo._();

  AppInfo.mockInit({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    required this.buildSignature,
    required this.deviceId,
    required this.appVersion,
    required this.device,
    required this.model,
    required this.isPhysicalDevice,
  });

  static Future<AppInfo> instance([AppInfo? mockInit]) async {
    _instance ??= mockInit ?? await AppInfo._()._init();
    return _instance!;
  }

  Future<AppInfo> _init() async {
    await Future.wait([
      _getPackageInfo(),
      _getDeviceId(),
      _getDeviceInfo(),
    ]);
    return this;
  }

  Future<void> _getPackageInfo() async {
    final info = await package.PackageInfo.fromPlatform();
    version = info.version;
    buildNumber = info.buildNumber;
    appName = info.appName;
    packageName = info.packageName;
    buildSignature = info.buildSignature;
  }

  Future<void> _getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final iosDeviceInfo = await deviceInfo.iosInfo;
        deviceId = iosDeviceInfo.identifierForVendor!;
      } else {
        final androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId = androidDeviceInfo.id.toString();
      }
    } catch (e) {
      debugPrint(e.toString());
      deviceId = '';
    }
  }

  Future<void> _getDeviceInfo() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final info = (await deviceInfo.iosInfo);
        appVersion = info.systemVersion;
        device = info.model;
        model = info.name;
        isPhysicalDevice = info.isPhysicalDevice;
      } else {
        final info = await deviceInfo.androidInfo;
        appVersion = info.version.release;
        device = info.brand + info.device;
        model = info.model;
        isPhysicalDevice = info.isPhysicalDevice;
      }
    } catch (e) {
      appVersion = '';
      device = '';
      model = '';
      isPhysicalDevice = null;
    }
  }

  static Future<int> getBatteryLevel() async {
    try {
      return await Battery().batteryLevel;
    } catch (e) {
      return -1;
    }
  }

  Map<String, dynamic> toMap() => {
        "appName": appName,
        "packageName": packageName,
        "version": version,
        "buildNumber": buildNumber,
        "buildSignature": buildSignature,
        "deviceId": deviceId,
        "app_version": appVersion,
        "device": device,
        "model": model,
        "isPhysicalDevice": isPhysicalDevice,
      };
}
