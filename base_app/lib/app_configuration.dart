import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';

import 'app/modules/home/presentation/home_routes.dart';
import 'core/constants/environment.dart';
import 'core/enums/flavors_enum.dart';

class AppConfiguration {
  Future<void> loadFlavor(Flavor currentFlavor) async {
    FlavorConfig.appFlavor = currentFlavor;
    await _loadEnv();
    log('App started with ${FlavorConfig.appFlavor} flavor');
  }

  Future<void> _loadEnv() async {
    var suffix = FlavorConfig.appFlavor!.name;
    suffix = suffix == Flavor.prod.name ? '' : '.$suffix';

    await dotenv.load(fileName: '.env/.env$suffix').catchError((onError) {
      log('AppConfiguration._loadEnv error: $onError');
    });
  }

  Environment get environment {
    final baseUrl = FlavorConfig.baseUrl;
    final api = dotenv.get('API', fallback: '');
    // final baseUrl = dotenv.get('BASE_URL', fallback: '');
    final clientId = dotenv.get('CLIENT_ID', fallback: '');
    final tenantId = dotenv.get('TENANT_ID', fallback: '');
    final redirectUri = dotenv.get('REDIRECT_URI', fallback: '');
    final clientSecret = dotenv.get('CLIENT_SECRET', fallback: '');
    final homeRoute = dotenv.get(
      'HOME_ROUTE',
      fallback: HomeRoutes.home.completePath,
    );

    return Environment(
      api: api,
      baseUrl: baseUrl,
      tenantId: tenantId,
      clientId: clientId,
      homeRoute: homeRoute,
      redirectUri: redirectUri,
      clientSecret: clientSecret,
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
