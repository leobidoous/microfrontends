import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppConfiguration {
  Future<void> loadFlavor(Flavor currentFlavor) async {
    FlavorConfig.appFlavor = currentFlavor;
    await _loadEnv();
    debugPrint('App started with ${FlavorConfig.appFlavor} flavor');
  }

  Future<void> _loadEnv() async {
    var suffix = FlavorConfig.appFlavor!.name;
    suffix = suffix == Flavor.prod.name ? '' : '.$suffix';

    await dotenv.load(fileName: '.env/.env$suffix').catchError((onError) {
      debugPrint('AppConfiguration._loadEnv error: $onError');
    });
  }

  EnvironmentEntity get environment {
    final api = dotenv.get('API', fallback: '');
    final baseUrl = dotenv.get('BASE_URL', fallback: '');
    final homeRoute = dotenv.get(
      'HOME_ROUTE',
      fallback: AppRoutes.home.completePath,
    );

    return EnvironmentEntity(
      api: api,
      baseUrl: baseUrl,
      homeRoute: homeRoute,
      appName: FlavorConfig.title,
      flavor: FlavorConfig.appFlavor,
    );
  }

  Future<DeviceInfoEntity> getDeviceInfo() async {
    if (Platform.isIOS) return DeviceInfoEntity();

    return DeviceInfoEntity();
  }

  Future<PackageInfoEntity> getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    return PackageInfoEntity(
      appName: info.appName,
      name: info.packageName,
      version: info.version,
      buildNumber: info.buildNumber,
      buildSignature: info.buildSignature,
    );
  }
}
