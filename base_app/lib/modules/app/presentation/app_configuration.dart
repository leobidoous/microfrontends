import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppConfiguration {
  Future<void> loadFlavor(Flavor currentFlavor) async {
    FlavorConfig.appFlavor = currentFlavor;
    await _loadEnv();
    debugPrint('App started with ${FlavorConfig.appFlavor} flavor');
  }

  Future<void> _loadEnv() async {
    var suffix = FlavorConfig.appFlavor!.name;
    suffix = suffix == Flavor.prod.name ? '' : '.$suffix';

    await dotenv
        .load(fileName: '.environment/.env$suffix')
        .catchError((onError) {
      debugPrint('AppConfiguration._loadEnv error: $onError');
      debugPrint('Verify folder /.enviroment');
    });
  }

  EnvironmentEntity get environment {
    final appBaseUrl = dotenv.get('APP_BASE_URL', fallback: '');
    final pwaBaseUrl = dotenv.get('PWA_BASE_URL', fallback: '');
    final dynamicLinkDomain = dotenv.get('DYNAMIC_LINK_DOMAIN', fallback: '');
    final iosBundleId = dotenv.get('IOS_BUNDLE_ID', fallback: '');
    final androidBundleId = dotenv.get('ANDROID_BUNDLE_ID', fallback: '');
    final zendeskAccountKey = dotenv.get('ZENDESK_ACCOUNT_KEY', fallback: '');
    final zendeskAppId = dotenv.get('ZENDESK_APP_ID', fallback: '');
    final sentryDsn = dotenv.get('SENTRY_DSN', fallback: '');
    final baseUrlParking = dotenv.get('BASE_URL_PARKING', fallback: '');
    final mixpanelToken = dotenv.get('MIXPANEL_TOKEN', fallback: '');
    final endpointCampaign = dotenv.get('ENDPOINT_CAMPAING', fallback: '');
    final getmoKey = dotenv.get('GETMO_KEY', fallback: '');
    final getmoSecret = dotenv.get('GETMO_SECRET', fallback: '');
    final endpointGraphql = dotenv.get('ENDPOINT_GRAPHQL', fallback: '');

    return EnvironmentEntity(
      appBaseUrl: appBaseUrl,
      pwaBaseUrl: pwaBaseUrl,
      dynamicLinkDomain: dynamicLinkDomain,
      iosBundleId: iosBundleId,
      androidBundleId: androidBundleId,
      zendeskAccountKey: zendeskAccountKey,
      zendeskAppId: zendeskAppId,
      sentryDsn: sentryDsn,
      baseUrlParking: baseUrlParking,
      mixpanelToken: mixpanelToken,
      endpointCampaign: endpointCampaign,
      getmoKey: getmoKey,
      getmoSecret: getmoSecret,
      endpointGraphql: endpointGraphql,
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
